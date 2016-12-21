#! /bin/sh
# This is a shell archive.  Remove anything before this line, then unpack
# it by saving it into a file and typing "sh file".  To overwrite existing
# files, type "sh file -c".  You can also feed this as standard input via
# unshar, or by typing "sh <file", e.g..  If this archive is complete, you
# will see the following message at the end:
#		"End of archive 3 (of 3)."
# Contents:  cshar.c makekit.c parser.c
# Wrapped by yaya@server.chm.bnl.gov on Sun Sep  3 19:20:14 1995
PATH=/bin:/usr/bin:/usr/ucb ; export PATH
if test -f 'cshar.c' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'cshar.c'\"
else
echo shar: Extracting \"'cshar.c'\" \(8685 characters\)
sed "s/^X//" >'cshar.c' <<'END_OF_FILE'
X/*
X**  CSHAR
X**  Make a C-shell archive of a list of files.
X*/
X#include "shar.h"
X#ifdef	RCSID
Xstatic char RCS[] =
X	"$Header: /user_data/systems/yaya/cif/shar/xcshar/cshar.c,v 1.4 1995/09/03 12:29:48 yaya Exp yaya $";
X#endif	/* RCSID */
X
X/*
X**  Minimum allocation of file name pointers used in "-i" option processing.
X*/
X#define	MIN_FILES	50
X
X
X/*
X**  This prolog is output before the archive.
X*/
Xstatic char	 *Prolog[] = {
X  "!/bin/csh",
X  " This is a C-shell archive.  Remove anything before this line, then unpack",
X  " it by saving it into a file and typing \"csh file\".  To overwrite ",
X  " existing files, type \"csh file -c\".  You may unpack by hand by",
X  " following the \"CUT_HERE_CUT_HERE...\" lines, but check for any lines",
X  " which begin with \"X\" and remove the \"X\"  If this archive is complete, you",
X  " will see the following message at the end:",
X  NULL
X};
X
X
X/*
X**  Package up one file or directory.
X*/
Xstatic void
Xshar(file, Basename)
X    char		*file;
X    int			 Basename;
X{
X    REGISTER char	*s;
X    REGISTER char	*Name;
X    REGISTER int	 Bads;
X    REGISTER off_t	 Size;
X    char		 buf[BUFSIZ];
X
X    /* Just in case. */
X    if (EQ(file, ".") || EQ(file, ".."))
X	return;
X
X    Size = Fsize(file);
X    Name =  Basename && (Name = RDX(file, '/')) ? Name + 1 : file;
X
X    /* Making a directory? */
X    if (Ftype(file) == F_DIR) {
X	Printf("if ( ! ( -e '%s' )) then\n", Name);
X	Printf(
X"    echo \"cshar: Creating directory \'%s\'\"\n", Name);
X	Printf("    mkdir '%s'\n", Name);
X        Printf("else\n");
X        Printf("  if ( ! ( -d '%s' )) then\n", Name);
X        Printf(
X"    echo \"cshar: Existing file conflicts with directory \'%s\'\"\n",
X        Name);
X        Printf("    exit(1)\n");
X        Printf("  endif\n");
X  	Printf("endif\n");
X    }
X    else {
X	if (freopen(file, "r", stdin) == NULL) {
X	    Fprintf(stderr, "Can't open %s, %s\n", file, Ermsg(errno));
X	    exit(1);
X	}
X
X	/* Emit the per-file prolog. */
X	Printf("if ( -e '%s' && ${1} != \"-c\" ) then \n", Name);
X	Printf(
X"  echo \"cshar: Will not clobber existing file \'%s\'\"\n",
X	Name);
X	Printf
X        ("sed \"s/^X//\" >'/dev/null' <<\"CUT_HERE_CUT_HERE_CUT_HERE\"\n",
X               Name);
X	Printf("else\n");
X	Printf(
X"  echo \"cshar: Extracting \'%s\' (%ld character%s)\"\n",
X	Name, (long)Size, Size == 1 ? "" : "s");
X        Printf(
X"\n\n\n#___________ THE FILE '%s' BEGINS TWO LINES AFTER THIS __________\n",
X        Name);
X	Printf(
X        "sed \"s/^X//\" >'%s' <<\"CUT_HERE_CUT_HERE_CUT_HERE\"\n",
X        Name);
X
X	/* Output the file contents. */
X	for (Bads = 0; fgets(buf, BUFSIZ, stdin); )
X	    if (buf[0]) {
X#ifdef  JUST_TEXT
X              if (EQn(buf,"\"CUT_HERE_CUT_HERE_CUT_HERE\"",28)
X                  || EQn(buf,"From",4) || buf[0] == 'X')
X                  (void)putchar('X');
X#else
X#ifdef	TOO_FANCY
X		if (buf[0] == 'X' || buf[0] == '\"' || buf[0] == 'F'
X		 || !isascii(buf[0]) || !isalpha(buf[0]))
X		    /* Protect non-alpha's, the shar pathtern character, the
X		     * CUT_HERE_CUT_HERE_CUT_HERE message, 
X                     * and mail "From" lines. */
X		    (void)putchar('X');
X#else
X		/* Always put out a leading X. */
X		(void)putchar('X');
X#endif	/* TOO_FANCY */
X#endif  /* JUST_TEXT */
X		for (s = buf; *s; s++) {
X		    if (BADCHAR(*s))
X			Bads++;
X		    (void)putchar(*s);
X		}
X	    }
X
X	Printf("\"CUT_HERE_CUT_HERE_CUT_HERE\"\n");
X        Printf(
X"#___________ THE FILE '%s' ENDS TWO LINES BEFORE THIS ___________\n\n\n\n", 
X        Name); 
X	/* Tell about and control characters. */
X	if (Bads) {
X	    Printf(
X"echo cshar: %d control character%s may be missing from \'%s\'\n",
X		   Bads, Bads == 1 ? "" : "s", Name);
X	    Fprintf(stderr, "Found %d control char%s in \"'%s'\"\n",
X		    Bads, Bads == 1 ? "" : "s", Name);
X	}
X
X	/* Output size check. */
X	Printf("if ( %ld != `wc -c <'%s'` ) then\n", (long)Size, Name);
X	Printf(
X"    echo \"cshar: \'%s\' unpacked with wrong size\"\n", Name);
X	Printf("endif\n");
X
X	/* Executable? */
X	if (Fexecute(file))
X	    Printf("chmod +x '%s'\n", Name);
X
X	Printf("# end of '%s'\nendif\n", Name);
X    }
X}
X
X
X/*
X**  Read list of files from file.
X*/
Xstatic char **
XGetFiles(Name)
X    char		 *Name;
X{
X    REGISTER FILE	 *F;
X    REGISTER int	  i;
X    REGISTER int	  count;
X    REGISTER char	**files;
X    REGISTER char	**temp;
X    REGISTER int	  j;
X    char		  buff[BUFSIZ];
X    char		 *p;
X
X    /* Open the file. */
X    if (EQ(Name, "-"))
X	F = stdin;
X    else if ((F = fopen(Name, "r")) == NULL) {
X	Fprintf(stderr, "Can't open '%s' for input.\n", Name);
X	return(NULL);
X    }
X
X    /* Get space. */
X    count = MIN_FILES;
X    files = NEW(char*, count);
X
X    /* Read lines. */
X    for (i = 0; fgets(buff, sizeof buff, F); ) {
X	if (p = IDX(buff, '\n'))
X	    *p = '\0';
X	files[i] = COPY(buff);
X	if (++i == count - 2) {
X	    /* Get more space; some systems don't have realloc()... */
X	    temp = NEW(char*, count);
X	    for (count += MIN_FILES, j = 0; j < i; j++)
X		temp[j] = files[j];
X	    files = temp;
X	}
X    }
X
X    /* Clean up, close up, return. */
X    files[i] = NULL;
X    (void)fclose(F);
X    return(files);
X}
X
X
Xmain(ac, av)
X    int			 ac;
X    REGISTER char	*av[];
X{
X    REGISTER char	*Trailer;
X    REGISTER char	*p;
X    REGISTER char	*q;
X    REGISTER int	 i;
X    REGISTER int	 length;
X    REGISTER int	 Oops;
X    REGISTER int	 Knum;
X    REGISTER int	 Kmax;
X    REGISTER int	 Basename;
X    REGISTER int	 j;
X    time_t		 clock;
X    char		**Flist;
X
X    /* Parse JCL. */
X    Basename = 0;
X    Knum = 0;
X    Kmax = 0;
X    Trailer = NULL;
X    Flist = NULL;
X    for (Oops = 0; (i = getopt(ac, av, "be:i:n:o:t:")) != EOF; )
X	switch (i) {
X	default:
X	    Oops++;
X	    break;
X	case 'b':
X	    Basename++;
X	    break;
X	case 'e':
X	    Kmax = atoi(optarg);
X	    break;
X	case 'i':
X	    Flist = GetFiles(optarg);
X	    break;
X	case 'n':
X	    Knum = atoi(optarg);
X	    break;
X	case 'o':
X	    if (freopen(optarg, "w", stdout) == NULL) {
X		Fprintf(stderr, "Can't open %s for output, %s.\n",
X			optarg, Ermsg(errno));
X		Oops++;
X	    }
X	    break;
X	case 't':
X	    Trailer = optarg;
X	    break;
X	}
X
X    /* Rest of arguments are files. */
X    if  (Flist == NULL) {
X	av += optind;
X	if (*av == NULL) {
X	    Fprintf(stderr, "No input files\n");
X	    Oops++;
X	}
X	Flist = av;
X    }
X
X    if (Oops) {
X	Fprintf(stderr,
X		"USAGE: cshar [-b] [-o:] [-i:] [-n:e:t:] file... >CSHAR\n");
X	exit(1);
X    }
X
X    /* Everything readable and reasonably-named? */
X    for (Oops = 0, i = 0; p = Flist[i]; i++)
X	if (freopen(p, "r", stdin) == NULL) {
X	    Fprintf(stderr, "Can't read %s, %s.\n", p, Ermsg(errno));
X	    Oops++;
X	}
X	else
X	    for (; *p; p++)
X		if (!isascii(*p)) {
X		    Fprintf(stderr, "Bad character '%c' in '%s'.\n",
X			    *p, Flist[i]);
X		    Oops++;
X		}
X    if (Oops)
X	exit(2);
X
X    /* Prolog. */
X    for (i = 0; p = Prolog[i]; i++)
X	Printf("#%s\n", p);
X    if (Knum && Kmax)
X	Printf("#\t\t\"End of archive %d (of %d).\"\n", Knum, Kmax);
X    else
X        Printf("#\t\t\"End of C-shell archive.\"\n");
X    Printf("# Contents: ");
X    for (length = 12, i = 0; p = Flist[i++]; length += j) {
X	if (Basename && (q = RDX(p, '/')))
X	    p = q + 1;
X	j = strlen(p) + 1;
X	if (length + j < WIDTH)
X	    Printf(" %s", p);
X	else {
X	    Printf("\n#   %s", p);
X	    length = 4;
X	}
X    }
X    Printf("\n");
X    clock = time((time_t *)NULL);
X    Printf("# Wrapped by %s@%s on %s", User(), Host(), ctime(&clock));
X    Printf("setenv PATH /bin:/usr/bin:/usr/ucb\n");
X
X    /* Do it. */
X    while (*Flist)
X	shar(*Flist++, Basename);
X
X    /* Epilog. */
X    if (Knum && Kmax) {
X	Printf(
X"echo \"cshar: End of archive %d (of %d).\"\n", Knum, Kmax);
X	Printf("cp /dev/null ark%disdone\n", Knum);
X	Printf("set MISSING=\"\"\n");
X	Printf("foreach I (");
X	for (i = 0; i < Kmax; i++)
X	    Printf(" %d", i + 1);
X	Printf(" )\n");
X	Printf("    if ( ! -e ark${I}isdone ) then\n");
X	Printf("set MISSING=\"${MISSING} ${I}\"\n");
X	Printf("    endif\n");
X	Printf("end\n");
X	Printf("if ( \"${MISSING}\" == \"\" ) then\n");
X	if (Kmax == 1)
X	    Printf("    echo You have the archive.\n");
X	else if (Kmax == 2)
X	    Printf("    echo You have unpacked both archives.\n");
X	else
X	    Printf("    echo You have unpacked all %d archives.\n", Kmax);
X	if (Trailer && *Trailer)
X	    Printf("    echo \"%s\"\n", Trailer);
X	Printf("    rm -f ark{1,2,3,4,5,6,7,8,9}isdone%s\n",
X	       Kmax >= 9 ? " ark{1,2}{0,1,2,3,4,5,6,7,8,9}isdone" : "");
X	Printf("else\n");
X	Printf("    echo You still need to unpack the following archives:\n");
X	Printf("    echo \"        \" ${MISSING}\n");
X	Printf("endif\n");
X	Printf("##  End of C-shell archive.\n");
X    }
X    else {
X        Printf("echo cshar: End of C-shell archive.\n");
X	if (Trailer && *Trailer)
X	    Printf("echo \"%s\"\n", Trailer);
X    }
X
X    Printf("exit 0\n");
X
X    exit(0);
X}
END_OF_FILE
if test 8685 -ne `wc -c <'cshar.c'`; then
    echo shar: \"'cshar.c'\" unpacked with wrong size!
fi
# end of 'cshar.c'
fi
if test -f 'makekit.c' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'makekit.c'\"
else
echo shar: Extracting \"'makekit.c'\" \(10825 characters\)
sed "s/^X//" >'makekit.c' <<'END_OF_FILE'
X/*
X**  MAKEKIT
X**  Split up source files into reasonably-sized shar lists.
X*/
X#include "shar.h"
X#ifdef	RCSID
Xstatic char RCS[] =
X	"$Header: /user_data/systems/yaya/cif/shar/xcshar/makekit.c,v 1.1 1995/09/02 23:16:16 yaya Exp yaya $";
X#endif	/* RCSID */
X
X
X/*
X**  Our block of information about the files we're doing.
X*/
Xtypedef struct _block {
X    char	*Name;			/* Filename			*/
X    char	*Text;			/* What it is			*/
X    int		 Where;			/* Where it is			*/
X    int		 Type;			/* Directory or file?		*/
X    long	 Bsize;			/* Size in bytes		*/
X} BLOCK;
X
X
X/*
X**  Our block of information about the archives we're making.
X*/
Xtypedef struct _archive {
X    int		 Count;			/* Number of files		*/
X    long	 Asize;			/* Bytes used by archive	*/
X} ARCHIVE;
X
X
X/*
X**  Format strings; these are strict K&R so you shouldn't have to change them.
X*/
X#define FORMAT1		" %-25s %2d\t%s\n"
X#define FORMAT2		"%s%2.2d"
X#ifdef	FMT02d
X#undef FORMAT2
X#define FORMAT2		"%s%02.2d"	/* I spoke too soon...		*/
X#endif	/* FMT02d */
X
X
X/*
X**  Global variables.
X*/
Xchar	*InName;			/* File with list to pack	*/
Xchar	*OutName;			/* Where our output goes	*/
Xchar	*SharName = "Part";		/* Prefix for name of each shar	*/
Xchar	*Trailer;			/* Text for shar to pack in	*/
Xchar	*TEMP;				/* Temporary manifest file	*/
X#ifdef	MSDOS
Xchar	*FLST;				/* File with list for shar	*/
X#endif	/* MSDOS */
Xint	 ArkCount = 20;			/* Max number of archives	*/
Xint	 ExcludeIt;			/* Leave out the output file?	*/
Xint	 Header;			/* Lines of prolog in input	*/
Xint	 Preserve;			/* Preserve order for Manifest?	*/
Xint	 Working = TRUE;		/* Call shar when done?		*/
Xlong	 Size = 55000;			/* Largest legal archive size	*/
X
X
X/*
X**  Sorting predicate to put README or MANIFEST first, then directories,
X**  then larger files, then smaller files, which is how we want to pack
X**  stuff in archives.
X*/
Xstatic int
XSizeP(t1, t2)
X    BLOCK	*t1;
X    BLOCK	*t2;
X{
X    long	 i;
X
X    if (t1->Type == F_DIR)
X	return(t2->Type == F_DIR ? 0 : -1);
X    if (t2->Type == F_DIR)
X	return(1);
X    if (EQn(t1->Name, "README", 6) || (OutName && EQ(t1->Name, OutName)))
X	return(-1);
X    if (EQn(t2->Name, "README", 6) || (OutName && EQ(t2->Name, OutName)))
X	return(1);
X    return((i = t1->Bsize - t2->Bsize) == 0L ? 0 : (i < 0L ? -1 : 1));
X}
X
X
X/*
X**  Sorting predicate to get things in alphabetical order, which is how
X**  we write the Manifest file.
X*/
Xstatic int
XNameP(t1, t2)
X    BLOCK	*t1;
X    BLOCK	*t2;
X{
X    int		 i;
X
X    return((i = *t1->Name - *t2->Name) ? i : strcmp(t1->Name, t2->Name));
X}
X
X
X/*
X**  Skip whitespace.
X*/
Xstatic char *
XSkip(p)
X    REGISTER char	*p;
X{
X    while (*p && WHITE(*p))
X	p++;
X    return(p);
X}
X
X
X/*
X**  Signal handler.  Clean up and die.
X*/
Xstatic sigret_t
XCatch(s)
X    int		 s;
X{
X    int		 e;
X
X    e = errno;
X    if (TEMP)
X	(void)unlink(TEMP);
X#ifdef	MSDOS
X    if (FLST)
X	(void)unlink(FLST);
X#endif	/* MSDOS */
X    Fprintf(stderr, "Got signal %d, %s.\n", s, Ermsg(e));
X    exit(1);
X}
X
X
Xmain(ac, av)
X    REGISTER int	 ac;
X    char		*av[];
X{
X    REGISTER FILE	*F;
X    REGISTER FILE	*In;
X    REGISTER BLOCK	*t;
X    REGISTER ARCHIVE	*k;
X    REGISTER char	*p;
X    REGISTER int	 i;
X    REGISTER int	 lines;
X    REGISTER int	 Value;
X    BLOCK		*Table;
X    BLOCK		*TabEnd;
X    ARCHIVE		*Ark;
X    ARCHIVE		*ArkEnd;
X    char		 buff[BUFSIZ];
X    long		 lsize;
X    int			 LastOne;
X    int			 Start;
X    int			 Notkits;
X    int			 Iscsh;
X    char		 EndArkNum[20];
X    char		 CurArkNum[20];
X
X    /* Collect input. */
X    Value = FALSE;
X    Notkits = FALSE;
X    Iscsh = FALSE;
X    while ((i = getopt(ac, av, "1ceh:i:k:n:mo:ps:t:x")) != EOF)
X	switch (i) {
X	default:
X	    Fprintf(stderr, "usage: makekit %s\n        %s\n",
X		    "[-1] [-c] [-e] [-x] [-k #] [-s #[k]] [-n Name] [-t Text]",
X		    "[-p] [-m | -i MANIFEST -o MANIFEST -h 2] [file ...]");
X	    exit(1);
X	case '1':
X	    Notkits = TRUE;
X	    break;
X	case 'c':
X	    Iscsh = TRUE;
X	    break;
X	case 'e':
X	    ExcludeIt = TRUE;
X	    break;
X	case 'h':
X	    Header = atoi(optarg);
X	    break;
X	case 'i':
X	    InName = optarg;
X	    break;
X	case 'k':
X	    ArkCount = atoi(optarg);
X	    break;
X	case 'm':
X	    InName = OutName = "MANIFEST";
X	    Header = 2;
X	    break;
X	case 'n':
X	    SharName = optarg;
X	    break;
X	case 'o':
X	    OutName = optarg;
X	    break;
X	case 'p':
X	    Preserve = TRUE;
X	    break;
X	case 's':
X	    Size = atoi(optarg);
X	    if (IDX(optarg, 'k') || IDX(optarg, 'K'))
X		Size *= 1024;
X	    break;
X	case 't':
X	    Trailer = optarg;
X	    break;
X	case 'x':
X	    Working = FALSE;
X	    break;
X	}
X    ac -= optind;
X    av += optind;
X
X    /* Write the file list to a temp file. */
X    TEMP = mktemp("/tmp/maniXXXXXX");
X    F = fopen(TEMP, "w");
X    SetSigs(TRUE, Catch);
X    if (av[0])
X	/* Got the arguments on the command line. */
X	while (*av)
X	    Fprintf(F, "%s\n", *av++);
X    else {
X	/* Got the name of the file from the command line. */
X	if (InName == NULL)
X	    In = stdin;
X	else if ((In = fopen(InName, "r")) == NULL) {
X	    Fprintf(stderr, "Can't read %s as manifest, %s.\n",
X		    InName, Ermsg(errno));
X	    exit(1);
X	}
X	/* Skip any possible prolog, then output rest of file. */
X	while (--Header >= 0 && fgets(buff, sizeof buff, In))
X	    ;
X	if (feof(In)) {
X	    Fprintf(stderr, "Nothing but header lines in list!?\n");
X	    exit(1);
X	}
X	while (fgets(buff, sizeof buff, In))
X	    fputs(buff, F);
X	if (In != stdin)
X	    (void)fclose(In);
X    }
X    (void)fclose(F);
X
X    /* Count number of files, allow for NULL and our output file. */
X    F = fopen(TEMP, "r");
X    for (lines = 2; fgets(buff, sizeof buff, F); lines++)
X	;
X    rewind(F);
X
X    /* Read lines and parse lines, see if we found our OutFile. */
X    Table = NEW(BLOCK, lines);
X    for (t = Table, Value = FALSE, lines = 0; fgets(buff, sizeof buff, F); ) {
X	/* Read line, skip first word, check for blank line. */
X	if (p = IDX(buff, '\n'))
X	    *p = '\0';
X	else
X	    Fprintf(stderr, "Warning, line truncated:\n%s\n", buff);
X	p = Skip(buff);
X	if (*p == '\0')
X	    continue;
X
X	/* Copy the line, snip off the first word. */
X	for (p = t->Name = COPY(p); *p && !WHITE(*p); p++)
X	    ;
X	if (*p)
X	    *p++ = '\0';
X
X	/* Skip <spaces><digits><spaces>; remainder is the file description. */
X	for (p = Skip(p); *p && isascii(*p) && isdigit(*p); )
X	    p++;
X	t->Text = Skip(p);
X
X	/* Get file type. */
X	if (!GetStat(t->Name)) {
X	    Fprintf(stderr, "Can't stat %s (%s), skipping.\n",
X		    t->Name, Ermsg(errno));
X	    continue;
X	}
X	t->Type = Ftype(t->Name);
X
X	/* Guesstimate its size when archived:  prolog, plus one char/line. */
X	t->Bsize = strlen(t->Name) * 3 + 200;
X	if (t->Type == F_FILE) {
X	    lsize = Fsize(t->Name);
X	    t->Bsize += lsize + lsize / 60;
X	}
X	if (t->Bsize > Size) {
X	    Fprintf(stderr, "At %ld bytes, %s is too big for any archive!\n",
X		    t->Bsize, t->Name);
X	    exit(1);
X	}
X
X	/* Is our ouput file there? */
X	if (!Value && OutName && EQ(OutName, t->Name))
X	    Value = TRUE;
X
X	/* All done -- advance to next entry. */
X	t++;
X    }
X    (void)fclose(F);
X    (void)unlink(TEMP);
X    SetSigs(S_RESET, (sigret_t (*)())NULL);
X
X    /* Add our output file? */
X    if (!ExcludeIt && !Value && OutName) {
X	t->Name = OutName;
X	t->Text = "This shipping list";
X	t->Type = F_FILE;
X	t->Bsize = lines * 60;
X	t++;
X    }
X
X    /* Sort by size, get archive space. */
X    lines = t - Table;
X    TabEnd = &Table[lines];
X    if (!Preserve)
X	qsort((char *)Table, lines, sizeof Table[0], SizeP);
X    Ark = NEW(ARCHIVE, ArkCount);
X    ArkEnd = &Ark[ArkCount];
X
X    /* Loop through the pieces, and put everyone into an archive. */
X    for (t = Table; t < TabEnd; t++) {
X	for (k = Ark; k < ArkEnd; k++)
X	    if (t->Bsize + k->Asize < Size) {
X		k->Asize += t->Bsize;
X		t->Where = k - Ark;
X		k->Count++;
X		break;
X	    }
X	if (k == ArkEnd) {
X	    Fprintf(stderr, "'%s' doesn't fit -- need more then %d archives.\n",
X		    t->Name, ArkCount);
X	    exit(1);
X	}
X	/* Since our share doesn't build sub-directories... */
X	if (t->Type == F_DIR && k != Ark)
X	    Fprintf(stderr, "Warning:  directory '%s' is in archive %d\n",
X		    t->Name, k - Ark + 1);
X    }
X
X    /* Open the output file. */
X    if (OutName == NULL)
X	F = stdout;
X    else {
X	if (GetStat(OutName)) {
X#ifdef	BACKUP_PREFIX
X	    (void)sprintf(buff, "%s%s", BACKUP_PREFIX, OutName);
X#else
X	    /* Handle /foo/bar/VeryLongFileName.BAK for non-BSD sites. */
X	    (void)sprintf(buff, "%s.BAK", OutName);
X	    p = (p = RDX(buff, '/')) ? p + 1 : buff;
X	    if (strlen(p) > 14)
X		/* ... well, sort of handle it. */
X		(void)strcpy(&p[10], ".BAK");
X#endif	/* BACKUP_PREFIX */
X	    Fprintf(stderr, "Renaming %s to %s\n", OutName, buff);
X	    (void)rename(OutName, buff);
X	}
X	if ((F = fopen(OutName, "w")) == NULL) {
X	    Fprintf(stderr, "Can't open '%s' for output, %s.\n",
X		    OutName, Ermsg(errno));
X	    exit(1);
X	}
X    }
X
X    /* Sort the shipping list, then write it. */
X    if (!Preserve)
X	qsort((char *)Table, lines, sizeof Table[0], NameP);
X    Fprintf(F, "   File Name\t\tArchive #\tDescription\n");
X    Fprintf(F, "-----------------------------------------------------------\n");
X    for (t = Table; t < TabEnd; t++)
X	Fprintf(F, FORMAT1, t->Name, t->Where + 1, t->Text);
X
X    /* Close output.  Are we done? */
X    if (F != stdout)
X	(void)fclose(F);
X    if (!Working)
X	exit(0);
X
X    /* Find last archive number. */
X    for (i = 0, t = Table; t < TabEnd; t++)
X	if (i < t->Where)
X	    i = t->Where;
X    LastOne = i + 1;
X
X    /* Find archive with most files in it. */
X    for (i = 0, k = Ark; k < ArkEnd; k++)
X	if (i < k->Count)
X	    i = k->Count;
X
X    /* Build the fixed part of the argument vector. */
X    av = NEW(char*, i + 10);
X    av[0] = "shar";
X    if (Iscsh == TRUE) {
X        av[0] = "cshar";
X    }
X    i = 1;
X    if (Trailer) {
X	av[i++] = "-t";
X	av[i++] = Trailer;
X    }
X    if (Notkits == FALSE) {
X	(void)sprintf(EndArkNum, "%d", LastOne);
X	av[i++] = "-e";
X	av[i++] = EndArkNum;
X	av[i++] = "-n";
X	av[i++] = CurArkNum;
X    }
X#ifdef	MSDOS
X    av[i++] = "-i";
X    av[i++] = FLST = mktemp("/tmp/manlXXXXXX");
X#endif	/* MSDOS */
X
X    av[i++] = "-o";
X    av[i++] = buff;
X
X    /* Call shar to package up each archive. */
X    for (Start = i, i = 0; i < LastOne; i++) {
X	(void)sprintf(CurArkNum, "%d", i + 1);
X	(void)sprintf(buff, FORMAT2, SharName, i + 1);
X#ifndef	MSDOS
X	for (lines = Start, t = Table; t < TabEnd; t++)
X	    if (t->Where == i)
X		av[lines++] = t->Name;
X	av[lines] = NULL;
X#else
X	if ((F = fopen(FLST, "w")) == NULL) {
X	    Fprintf(stderr, "Can't open list file '%s' for output, %s.\n",
X		    FLST, Ermsg(errno));
X	    exit(1);
X	}
X	for (t = Table; t < TabEnd; t++)
X	    if (t->Where == i)
X		Fprintf(F, "%s\n", t->Name);
X	(void)fclose(F);
X#endif /* MSDOS */
X	Fprintf(stderr, "Packing kit %d...\n", i + 1);
X	if (lines = Execute(av))
X	    Fprintf(stderr, "Warning:  shar returned status %d.\n", lines);
X    }
X
X#ifdef	MSDOS
X    (void)unlink(FLST);
X#endif	/* MSDOS */
X    /* That's all she wrote. */
X    exit(0);
X}
END_OF_FILE
if test 10825 -ne `wc -c <'makekit.c'`; then
    echo shar: \"'makekit.c'\" unpacked with wrong size!
fi
# end of 'makekit.c'
fi
if test -f 'parser.c' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'parser.c'\"
else
echo shar: Extracting \"'parser.c'\" \(24180 characters\)
sed "s/^X//" >'parser.c' <<'END_OF_FILE'
X/*
X**  An interpreter that can unpack many /bin/sh shell archives.
X**  This program should really be split up into a couple of smaller
X**  files; it started with Argify and SynTable as a cute ten-minute
X**  hack and it just grew.
X**
X**  Also, note that (void) casts abound, and that every command goes
X**  to some trouble to return a value.  That's because I decided
X**  not to implement $? "properly."
X*/
X#include "shar.h"
X#ifdef	RCSID
Xstatic char RCS[] =
X	"$Header: parser.c,v 2.1 88/06/03 11:39:11 rsalz Exp $";
X#endif	/* RCSID */
X
X
X/*
X**  Manifest constants, handy shorthands.
X*/
X
X/* Character classes used in the syntax table. */
X#define C_LETR		1		/* A letter within a word	*/
X#define C_WHIT		2		/* Whitespace to separate words	*/
X#define C_WORD		3		/* A single-character word	*/
X#define C_DUBL		4		/* Something like <<, e.g.	*/
X#define C_QUOT		5		/* Quotes to group a word	*/
X#define C_META		6		/* Heavy magic character	*/
X#define C_TERM		7		/* Line terminator		*/
X
X/* Macros used to query character class. */
X#define ISletr(c)	(SynTable[(c)] == C_LETR)
X#define ISwhit(c)	(SynTable[(c)] == C_WHIT)
X#define ISword(c)	(SynTable[(c)] == C_WORD)
X#define ISdubl(c)	(SynTable[(c)] == C_DUBL)
X#define ISquot(c)	(SynTable[(c)] == C_QUOT)
X#define ISmeta(c)	(SynTable[(c)] == C_META)
X#define ISterm(c)	(SynTable[(c)] == C_TERM)
X
X
X/*
X**  Data types
X*/
X
X/* Command dispatch table. */
Xtypedef struct {
X    char	  Name[10];		/* Text of command name		*/
X    int		(*Func)();		/* Function that implements it	*/
X} COMTAB;
X
X/* A shell variable.  We only have a few of these. */
Xtypedef struct {
X    char	 *Name;
X    char	 *Value;
X} VAR;
X
X
X/*
X**  Global variables.
X*/
X
XFILE		*Input;			/* Current input stream		*/
Xchar		*File;			/* Input filename		*/
Xint		 Interactive;		/* isatty(fileno(stdin))?	*/
X#ifdef	MSDOS
Xjmp_buf		 jEnv;			/* Pop out of main loop		*/
X#endif	MSDOS
X
Xstatic VAR	 VarList[MAX_VARS];	/* Our list of variables	*/
Xstatic char	 Text[BUFSIZ];		/* Current text line		*/
Xstatic int	 LineNum = 1;		/* Current line number		*/
Xstatic int	 Running = TRUE;	/* Working, or skipping?	*/
Xstatic short	 SynTable[256] = {	/* Syntax table			*/
X    /*	\0	001	002	003	004	005	006	007	*/
X	C_TERM,	C_WHIT,	C_WHIT,	C_WHIT,	C_WHIT,	C_WHIT,	C_WHIT,	C_WHIT,
X    /*	\h	\t	\n	013	\f	\r	016	017	*/
X	C_WHIT,	C_WHIT,	C_TERM,	C_WHIT,	C_TERM,	C_TERM,	C_WHIT,	C_WHIT,
X    /*	020	021	022	023	024	025	026	027	*/
X	C_WHIT,	C_WHIT,	C_WHIT,	C_WHIT,	C_WHIT,	C_WHIT,	C_WHIT,	C_WHIT,
X    /*	can	em	sub	esc	fs	gs	rs	us	*/
X	C_WHIT,	C_WHIT,	C_WHIT,	C_WHIT,	C_WHIT,	C_WHIT,	C_WHIT,	C_WHIT,
X
X    /*	sp	!	"	#	$	%	&	'	*/
X	C_WHIT,	C_LETR,	C_QUOT,	C_TERM,	C_LETR,	C_LETR,	C_DUBL,	C_QUOT,
X    /*	(	)	*	+	,	-	.	/	*/
X	C_WORD,	C_WORD,	C_LETR,	C_LETR,	C_LETR,	C_LETR,	C_LETR,	C_LETR,
X    /*	0	1	2	3	4	5	6	7	*/
X	C_LETR,	C_LETR,	C_LETR,	C_LETR,	C_LETR,	C_LETR,	C_LETR,	C_LETR,
X    /*	8	9	:	;	<	=	>	?	*/
X	C_LETR,	C_LETR,	C_LETR,	C_DUBL,	C_DUBL,	C_LETR,	C_DUBL,	C_LETR,
X
X    /*	@	A	B	C	D	E	F	G	*/
X	C_LETR,	C_LETR,	C_LETR,	C_LETR,	C_LETR,	C_LETR,	C_LETR,	C_LETR,
X    /*	H	I	J	K	L	M	N	O	*/
X	C_LETR,	C_LETR,	C_LETR,	C_LETR,	C_LETR,	C_LETR,	C_LETR,	C_LETR,
X    /*	P	Q	R	S	T	U	V	W	*/
X	C_LETR,	C_LETR,	C_LETR,	C_LETR,	C_LETR,	C_LETR,	C_LETR,	C_LETR,
X    /*	X	Y	Z	[	\	]	^	_	*/
X	C_LETR,	C_LETR,	C_LETR,	C_LETR,	C_META,	C_LETR,	C_LETR,	C_LETR,
X
X    /*	`	a	b	c	d	e	f	g	*/
X	C_WORD,	C_LETR,	C_LETR,	C_LETR,	C_LETR,	C_LETR,	C_LETR,	C_LETR,
X    /*	h	i	j	k	l	m	n	o	*/
X	C_LETR,	C_LETR,	C_LETR,	C_LETR,	C_LETR,	C_LETR,	C_LETR,	C_LETR,
X    /*	p	q	r	s	t	u	v	w	*/
X	C_LETR,	C_LETR,	C_LETR,	C_LETR,	C_LETR,	C_LETR,	C_LETR,	C_LETR,
X    /*	x	y	z	{	|	}	~	del	*/
X	C_LETR,	C_LETR,	C_LETR,	C_LETR,	C_DUBL,	C_LETR,	C_LETR,	C_WHIT,
X};
X
X/**
X***		E R R O R   R O U T I N E S
X**/
X
X
X/*
X**  Print message with current line and line number.
X*/
Xstatic void
XNote(text, arg)
X    char	*text;
X    char	*arg;
X{
X    Fprintf(stderr, "\nIn line %d of %s:\n\t", LineNum, File);
X    Fprintf(stderr, text, arg);
X    Fprintf(stderr, "Current line:\n\t%s\n", Text);
X    (void)fflush(stderr);
X}
X
X
X/*
X**  Print syntax message and die.
X*/
Xvoid
XSynErr(text)
X    char	*text;
X{
X    Note("Fatal syntax error in %s statement.\n", text);
X    exit(1);
X}
X
X/**
X***		I N P U T   R O U T I N E S
X**/
X
X
X/*
X**  Miniscule regular-expression matcher; only groks the . meta-character.
X*/
Xstatic int
XMatches(p, text)
X    REGISTER char	*p;
X    REGISTER char	*text;
X{
X    for (; *p && *text; text++, p++)
X	if (*p != *text && *p != '.')
X	    return(FALSE);
X    return(TRUE);
X}
X
X
X
X/*
X**  Read input, possibly handling escaped returns.  Returns a value so
X**  we can do things like "while (GetLine(TRUE))", which is a hack.  This
X**  should also be split into two separate routines, and punt the Flag
X**  argument, but so it goes.
X*/
Xint
XGetLine(Flag)
X    REGISTER int	 Flag;
X{
X    REGISTER char	*p;
X    REGISTER char	*q;
X    char		 buf[LINE_SIZE];
X
X    if (Interactive) {
X	Fprintf(stderr, "Line %d%s>  ", LineNum, Running ? "" : "(SKIP)");
X	(void)fflush(stderr);
X    }
X    Text[0] = '\0';
X    for (q = Text; fgets(buf, sizeof buf, Input); q += strlen(strcpy(q, buf))) {
X	LineNum++;
X	p = &buf[strlen(buf) - 1];
X	if (*p != '\n') {
X	    Note("Input line too long.\n", (char *)NULL);
X	    exit(1);
X	}
X	if (!Flag || p == buf || p[-1] != '\\') {
X	    (void)strcpy(q, buf);
X	    return(1);
X	}
X	p[-1] = '\0';
X	if (Interactive) {
X	    Fprintf(stderr, "PS2>  ");
X	    (void)fflush(stderr);
X	}
X    }
X    Note("RAN OUT OF INPUT.\n", (char *)NULL);
X    exit(1);
X    /* NOTREACHED */
X}
X
X
X/*
X**  Copy a sub-string of characters into dynamic space.
X*/
Xstatic char *
XCopyRange(Start, End)
X    char	*Start;
X    char	*End;
X{
X    char	*p;
X    int		 i;
X
X    i = End - Start + 1;
X    p = strncpy(NEW(char, i + 1), Start, i);
X    p[i] = '\0';
X    return(p);
X}
X
X
X/*
X**  Split a line up into shell-style "words."
X*/
Xint
XArgify(ArgV)
X    char		**ArgV;
X{
X    REGISTER char	**av;
X    REGISTER char	 *p;
X    REGISTER char	 *q;
X    
X    for (av = ArgV, p = Text; *p; p++) {
X	/* Skip whitespace, but treat "\ " as a letter. */
X	for (; ISwhit(*p); p++)
X	    if (ISmeta(*p))
X		p++;
X	if (ISterm(*p))
X	    break;
X	switch (SynTable[*p]) {
X	default:
X	    Note("Bad case %x in Argify.\n", (char *)SynTable[*p]);
X	    /* FALLTHROUGH */
X	case C_META:
X	    p++;
X	    /* FALLTHROUGH */
X	case C_WHIT:
X	case C_LETR:
X	    for (q = p; ISletr(*++q) || ISmeta(q[-1]); )
X		;
X	    *av++ = CopyRange(p, --q);
X	    p = q;
X	    break;
X	case C_DUBL:
X	    if (*p == p[1]) {
X		*av++ = CopyRange(p, p + 1);
X		p++;
X		break;
X	    }
X	    /* FALLTHROUGH */
X	case C_WORD:
X	    *av++ = CopyRange(p, p);
X	    break;
X	case C_QUOT:
X	    for (q = p; *++q; )
X		if (*q == *p && !ISmeta(q[-1]))
X		    break;
X	    *av++ = CopyRange(p + 1, q - 1);
X	    p = q;
X	    break;
X	}
X    }
X    *av = NULL;
X    if (av > &ArgV[MAX_WORDS - 1])
X	SynErr("TOO MANY WORDS IN LINE");
X    return(av - ArgV);
X}
X
X/**
X***		V A R I A B L E   R O U T I N E S
X**/
X
X
X/*
X**  Return the value of a variable, or an empty string.
X*/
Xstatic char *
XGetVar(Name)
X    REGISTER char	*Name;
X{
X    REGISTER VAR	*Vptr;
X
X    for (Vptr = VarList; Vptr < &VarList[MAX_VARS]; Vptr++)
X	if (EQ(Vptr->Name, Name))
X	    return(Vptr->Value);
X
X    /* Try the environment. */
X    return((Name = getenv(Name)) ? Name : "");
X}
X
X
X/*
X**  Insert a variable/value pair into the list of variables.
X*/
Xvoid
XSetVar(Name, Value)
X    REGISTER char	*Name;
X    REGISTER char	*Value;
X{
X    REGISTER VAR	*Vptr;
X    REGISTER VAR	*FreeVar;
X
X    /* Skip leading whitespace in variable names, sorry... */
X    while (ISwhit(*Name))
X	Name++;
X
X    /* Try to find the variable in the table. */
X    for (Vptr = VarList, FreeVar = NULL; Vptr < &VarList[MAX_VARS]; Vptr++)
X	if (Vptr->Name) {
X	    if (EQ(Vptr->Name, Name)) {
X		free(Vptr->Value);
X		Vptr->Value = COPY(Value);
X		return;
X	    }
X	}
X	else if (FreeVar == NULL)
X	    FreeVar = Vptr;
X
X    if (FreeVar == NULL) {
X	Fprintf(stderr, "Overflow, can't do '%s=%s'\n", Name, Value);
X	SynErr("ASSIGNMENT");
X    }
X    FreeVar->Name = COPY(Name);
X    FreeVar->Value = COPY(Value);
X}
X
X
X/*
X**  Expand variable references inside a word that are of the form:
X**	foo${var}bar
X**	foo$$bar
X**  Returns a pointer to a static area which is overwritten every
X**  other time it is called, so that we can do EQ(Expand(a), Expand(b)).
X*/
Xstatic char *
XExpand(p)
X    REGISTER char	*p;
X{
X    static char		 buff[2][VAR_VALUE_SIZE];
X    static int		 Flag;
X    REGISTER char	*q;
X    REGISTER char	*n;
X    REGISTER char	 Closer;
X    char		 name[VAR_NAME_SIZE];
X
X    /* This is a hack, but it makes things easier in DoTEST, q.v. */
X    if (p == NULL)
X	return(p);
X
X    /* Pick the "other" buffer then loop over the string to be expanded. */
X    for (Flag = 1 - Flag, q = buff[Flag]; *p; )
X	if (*p == '$')
X	    if (*++p == '$') {
X		(void)sprintf(name, "%d", Pid());
X		q += strlen(strcpy(q, name));
X		p++;
X	    }
X	    else if (*p == '?') {
X		/* Fake it -- all commands always succeed, here. */
X		*q++ = '0';
X		*q = '\0';
X		p++;
X	    }
X	    else {
X		Closer =  (*p == '{') ? *p++ : '\0';
X		for (n = name; *p && *p != Closer; )
X		    *n++ = *p++;
X		if (*p)
X		    p++;
X		*n = '\0';
X		q += strlen(strcpy(q, GetVar(name)));
X	    }
X	else
X	    *q++ = *p++;
X    *q = '\0';
X    return(buff[Flag]);
X}
X
X
X/*
X**  Do a variable assignment of the form:
X**	var=value
X**	var="quoted value"
X**	var="...${var}..."
X**	etc.
X*/
Xstatic void
XDoASSIGN(Name)
X    REGISTER char	*Name;
X{
X    REGISTER char	*Value;
X    REGISTER char	*q;
X    REGISTER char	 Quote;
X
X    /* Split out into name:value strings, and deal with quoted values. */
X    Value = IDX(Name, '=');
X    *Value = '\0';
X    if (ISquot(*++Value))
X	for (Quote = *Value++, q = Value; *++q && *q != Quote; )
X	    ;
X    else
X	for (q = Value; ISletr(*q); q++)
X	    ;
X    *q = '\0';
X
X    SetVar(Name, Expand(Value));
X}
X
X/**
X***		" O U T P U T "   C O M M A N D S
X**/
X
X
X/*
X**  Do a cat command.  Understands the following:
X**	cat >arg1 <<arg2
X**	cat >>arg1 <<arg2
X**	cat >>arg1 /dev/null
X**  Except that arg2 is assumed to be quoted -- i.e., no expansion of meta-chars
X**  inside the "here" document is done.  The IO redirection can be in any order.
X*/
X/* ARGSUSED */
Xstatic int
XDoCAT(ac, av)
X    int			 ac;
X    REGISTER char	*av[];
X{
X    REGISTER FILE	*Out;
X    REGISTER char	*Ending;
X    REGISTER char	*Source;
X    REGISTER int	 V;
X    REGISTER int	 l;
X
X    /* Parse the I/O redirecions. */
X    for (V = TRUE, Source = NULL, Out = NULL, Ending = NULL; *++av; )
X	if (EQ(*av, ">") && av[1]) {
X	    av++;
X	    /* This is a hack, but maybe MS-DOS doesn't have /dev/null? */
X	    Out = Running ? fopen(Expand(*av), "w") : stderr;
X	}
X	else if (EQ(*av, ">>") && av[1]) {
X	    av++;
X	    /* And besides, things are actually faster this way. */
X	    Out = Running ? fopen(Expand(*av), "a") : stderr;
X	}
X	else if (EQ(*av, "<<") && av[1]) {
X	    for (Ending = *++av; *Ending == '\\'; Ending++)
X		;
X	    l = strlen(Ending);
X	}
X	else if (!EQ(Source = *av, "/dev/null"))
X	    SynErr("CAT (bad input filename)");
X
X    if (Out == NULL || (Ending == NULL && Source == NULL)) {
X	Note("Missing parameter in CAT command.\n", (char *)NULL);
X	V = FALSE;
X    }
X
X    /* Read the input, spit it out. */
X    if (V && Running && Out != stderr) {
X	if (Source == NULL)
X	    while (GetLine(FALSE) && !EQn(Text, Ending, l))
X		(void)fputs(Text, Out);
X	(void)fclose(Out);
X    }
X    else
X	while (GetLine(FALSE) && !EQn(Text, Ending, l))
X	    ;
X
X    return(V);
X}
X
X
X/*
X**  Do a SED command.  Understands the following:
X**	sed sX^yyyyXX >arg1 <<arg2
X**	sed -e sX^yyyyXX >arg1 <<arg2
X**  Where the yyyy is a miniscule regular expression; see Matches(), above.
X**  The "X" can be any single character and the ^ is optional (sigh).  No
X**  shell expansion is done inside the "here' document.  The IO redirection
X**  can be in any order.
X*/
X/* ARGSUSED */
Xstatic int
XDoSED(ac, av)
X    int			 ac;
X    REGISTER char	*av[];
X{
X    REGISTER FILE	*Out;
X    REGISTER char	*Pattern;
X    REGISTER char	*Ending;
X    REGISTER char	*p;
X    REGISTER int	 V;
X    REGISTER int	 l;
X    REGISTER int	 i;
X
X    /* Parse IO redirection stuff. */
X    for (V = TRUE, Out = NULL, Pattern = NULL, Ending = NULL; *++av; )
X	if (EQ(*av, ">") && av[1]) {
X	    av++;
X	    Out = Running ? fopen(Expand(*av), "w") : stderr;
X	}
X	else if (EQ(*av, ">>") && av[1]) {
X	    av++;
X	    Out = Running ? fopen(Expand(*av), "a") : stderr;
X	}
X	else if (EQ(*av, "<<") && av[1]) {
X	    for (Ending = *++av; *Ending == '\\'; Ending++)
X		;
X	    l = strlen(Ending);
X	}
X	else
X	    Pattern = EQ(*av, "-e") && av[1] ? *++av : *av;
X
X    /* All there? */
X    if (Out == NULL || Ending == NULL || Pattern == NULL) {
X	Note("Missing parameter in SED command.\n", (char *)NULL);
X	V = FALSE;
X    }
X
X    /* Parse the substitute command and its pattern. */
X    if (*Pattern != 's') {
X	Note("Bad SED command -- not a substitute.\n", (char *)NULL);
X	V = FALSE;
X    }
X    else {
X	Pattern++;
X	p = Pattern + strlen(Pattern) - 1;
X	if (*p != *Pattern || *--p != *Pattern) {
X	    Note("Bad substitute pattern in SED command.\n", (char *)NULL);
X	    V = FALSE;
X	}
X	else {
X	    /* Now check the pattern. */
X	    if (*++Pattern == '^')
X		Pattern++;
X	    for (*p = '\0', i = strlen(Pattern), p = Pattern; *p; p++)
X		if (*p == '[' || *p == '*' || *p == '$') {
X		    Note("Bad meta-character in SED pattern.\n", (char *)NULL);
X		    V = FALSE;
X		}
X	}
X    }
X
X    /* Spit out the input. */
X    if (V && Running && Out != stderr) {
X	while (GetLine(FALSE) && !EQn(Text, Ending, l))
X	    (void)fputs(Matches(Pattern, Text) ? &Text[i] : Text, Out);
X	(void)fclose(Out);
X    }
X    else
X	while (GetLine(FALSE) && !EQn(Text, Ending, l))
X	    ;
X
X    return(V);
X}
X
X/**
X***		" S I M P L E "   C O M M A N D S
X**/
X
X
X/*
X**  Parse a cp command of the form:
X**	cp /dev/null arg
X**  We should check if "arg" is a safe file to clobber, but...
X*/
Xstatic int
XDoCP(ac, av)
X    int		 ac;
X    char	*av[];
X{
X    FILE	*F;
X
X    if (Running) {
X	if (ac != 3 || !EQ(av[1], "/dev/null"))
X	    SynErr("CP");
X	if (F = fopen(Expand(av[2]), "w")) {
X	    (void)fclose(F);
X	    return(TRUE);
X	}
X	Note("Can't create %s.\n", av[2]);
X    }
X    return(FALSE);
X}
X
X
X/*
X**  Do a mkdir command of the form:
X**	mkdir arg
X*/
Xstatic int
XDoMKDIR(ac, av)
X    int		 ac;
X    char	*av[];
X{
X    if (Running) {
X	if (ac != 2)
X	    SynErr("MKDIR");
X	if (mkdir(Expand(av[1]), 0777) >= 0)
X	    return(TRUE);
X	Note("Can't make directory %s.\n", av[1]);
X    }
X    return(FALSE);
X}
X
X
X/*
X**  Do a cd command of the form:
X**	cd arg
X**	chdir arg
X*/
Xstatic int
XDoCD(ac, av)
X    int		 ac;
X    char	*av[];
X{
X    if (Running) {
X	if (ac != 2)
X	    SynErr("CD");
X	if (chdir(Expand(av[1])) >= 0)
X	    return(TRUE);
X	Note("Can't cd to %s.\n", av[1]);
X    }
X    return(FALSE);
X}
X
X
X/*
X**  Do the echo command.  Understands the "-n" hack.
X*/
X/* ARGSUSED */
Xstatic int
XDoECHO(ac, av)
X    int		 ac;
X    char	*av[];
X{
X    int		 Flag;
X
X    if (Running) {
X	if (Flag = av[1] != NULL && EQ(av[1], "-n"))
X	    av++;
X	while (*++av)
X	    Fprintf(stderr, "%s ", Expand(*av));
X	if (!Flag)
X	    Fprintf(stderr, "\n");
X	(void)fflush(stderr);
X    }
X    return(TRUE);
X}
X
X
X/*
X**  Generic "handler" for commands we can't do.
X*/
Xstatic int
XDoIT(ac, av)
X    int		 ac;
X    char	*av[];
X{
X    if (Running)
X	Fprintf(stderr, "You'll have to do this yourself:\n\t%s ", *av);
X    return(DoECHO(ac, av));
X}
X
X
X/*
X**  Do an EXIT command.
X*/
Xstatic int
XDoEXIT(ac, av)
X    int		 ac;
X    char	*av[];
X{
X    ac = *++av ? atoi(Expand(*av)) : 0;
X    Fprintf(stderr, "Exiting, with status %d\n", ac);
X#ifdef	MSDOS
X    longjmp(jEnv, 1);
X#endif	/* MSDOS */
X    return(ac);
X}
X
X
X/*
X**  Do an EXPORT command.  Often used to make sure the archive is being
X**  unpacked with the Bourne (or Korn?) shell.  We look for:
X**	export PATH blah blah blah
X*/
Xstatic int
XDoEXPORT(ac, av)
X    int		 ac;
X    char	*av[];
X{
X    if (ac < 2 || !EQ(av[1], "PATH"))
X	SynErr("EXPORT");
X    return(TRUE);
X}
X
X/**
X***		F L O W - O F - C O N T R O L   C O M M A N D S
X**/
X
X
X/*
X**  Parse a "test" statement.  Returns TRUE or FALSE.  Understands the
X**  following tests:
X**	test {!} -f arg		Is arg {not} a plain file?
X**	test {!} -d arg		Is arg {not} a directory?
X**	test {!} $var -eq $var	Is the variable {not} equal to the variable?
X**	test {!} $var != $var	Is the variable {not} equal to the variable?
X**	test {!} ddd -ne `wc -c {<} arg`
X**				Is size of arg {not} equal to ddd in bytes?
X**	test -f arg -a $var -eq val
X**				Used by my shar, check for file clobbering
X**  These last two tests are starting to really push the limits of what is
X**  reasonable to hard-code, but they are common cliches in shell archive
X**  "programming."  We also understand the [ .... ] way of writing test.
X**  If we can't parse the test, we show the command and ask the luser.
X*/
Xstatic int
XDoTEST(ac, av)
X    REGISTER int	  ac;
X    REGISTER char	 *av[];
X{
X    REGISTER char	**p;
X    REGISTER char	 *Name;
X    REGISTER FILE	 *DEVTTY;
X    REGISTER int	  V;
X    REGISTER int	  i;
X    char		  buff[LINE_SIZE];
X
X    /* Quick test. */
X    if (!Running)
X	return(FALSE);
X
X    /* See if we're called as "[ ..... ]" */
X    if (EQ(*av, "[")) {
X	for (i = 1; av[i] && !EQ(av[i], "]"); i++)
X	    ;
X	free(av[i]);
X	av[i] = NULL;
X	ac--;
X    }
X
X    /* Ignore the "test" argument. */
X    av++;
X    ac--;
X
X    /* Inverted test? */
X    if (EQ(*av, "!")) {
X	V = FALSE;
X	av++;
X	ac--;
X    }
X    else
X	V = TRUE;
X
X    /* Testing for file-ness? */
X    if (ac == 2 && EQ(av[0], "-f") && (Name = Expand(av[1])))
X	return(GetStat(Name) && Ftype(Name) == F_FILE ? V : !V);
X
X    /* Testing for directory-ness? */
X    if (ac == 2 && EQ(av[0], "-d") && (Name = Expand(av[1])))
X	return(GetStat(Name) && Ftype(Name) == F_DIR ? V : !V);
X
X    /* Testing a variable's value? */
X    if (ac == 3 && (EQ(av[1], "-eq") || EQ(av[1], "=")))
X	return(EQ(Expand(av[0]), Expand(av[2])) ? V : !V);
X    if (ac == 3 && (EQ(av[1], "-ne") || EQ(av[1], "!=")))
X	return(!EQ(Expand(av[0]), Expand(av[2])) ? V : !V);
X
X    /* Testing a file's size? */
X    if (ac == (av[5] && EQ(av[5], "<") ? 8 : 7)
X     && isascii(av[0][0]) && isdigit(av[0][0])
X     && (EQ(av[1], "-ne") || EQ(av[1], "-eq"))
X     && EQ(av[2], "`") && EQ(av[3], "wc")
X     && EQ(av[4], "-c") && EQ(av[ac - 1], "`")) {
X	if (GetStat(av[ac - 2])) {
X	    if (EQ(av[1], "-ne"))
X		return(Fsize(av[ac - 2]) != atol(av[0]) ? V : !V);
X	    return(Fsize(av[ac - 2]) == atol(av[0]) ? V : !V);
X	}
X	Note("Can't get status of %s.\n", av[ac - 2]);
X    }
X
X    /* Testing for existing, but can clobber? */
X    if (ac == 6 && EQ(av[0], "-f") && EQ(av[2], "-a")
X     && (EQ(av[4], "!=") || EQ(av[4], "-ne")))
X	return(GetStat(Name = Expand(av[1])) && Ftype(Name) == F_FILE
X	       && EQ(Expand(av[3]), Expand(av[5])) ? !V : V);
X
X    /* I give up -- print it out, and let's ask Mikey, he can do it... */
X    Fprintf(stderr, "Can't parse this test:\n\t");
X    for (i = FALSE, p = av; *p; p++) {
X	Fprintf(stderr, "%s ", *p);
X	if (p[0][0] == '$')
X	    i = TRUE;
X    }
X    if (i) {
X	Fprintf(stderr, "\n(Here it is with shell variables expanded...)\n\t");
X	for (p = av; *p; p++)
X	    Fprintf(stderr, "%s ", Expand(*p));
X    }
X    Fprintf(stderr, "\n");
X
X    DEVTTY = fopen(THE_TTY, "r");
X    do {
X	Fprintf(stderr, "Is value true/false/quit [tfq] (q):  ");
X	(void)fflush(stderr);
X	clearerr(DEVTTY);
X	if (fgets(buff, sizeof buff, DEVTTY) == NULL
X	 || buff[0] == 'q' || buff[0] == 'Q' || buff[0] == '\n')
X	    SynErr("TEST");
X	if (buff[0] == 't' || buff[0] == 'T') {
X	    (void)fclose(DEVTTY);
X	    return(TRUE);
X	}
X    } while (buff[0] != 'f' && buff[0] != 'F');
X    (void)fclose(DEVTTY);
X    return(FALSE);
X}
X
X
X/*
X**  Do an IF statement.
X*/
Xstatic int
XDoIF(ac, av)
X    REGISTER int	 ac;
X    REGISTER char	*av[];
X{
X    REGISTER char	**p;
X    REGISTER int	  Flag;
X    char		 *vec[MAX_WORDS];
X    char		**Pushed;
X
X    /* Skip first argument. */
X    if (!EQ(*++av, "[") && !EQ(*av, "test"))
X	SynErr("IF");
X    ac--;
X
X    /* Look for " ; then " on this line, or "then" on next line. */
X    for (Pushed = NULL, p = av; *p; p++)
X	if (Flag = EQ(*p, ";")) {
X	    if (p[1] == NULL || !EQ(p[1], "then"))
X		SynErr("IF");
X	    *p = NULL;
X	    ac -= 2;
X	    break;
X	}
X    if (!Flag) {
X	(void)GetLine(TRUE);
X	if (Argify(vec) > 1)
X	    Pushed = &vec[1];
X	if (!EQ(vec[0], "then"))
X	    SynErr("IF (missing THEN)");
X    }
X
X    if (DoTEST(ac, av)) {
X	if (Pushed)
X	    (void)Exec(Pushed);
X	while (GetLine(TRUE)) {
X	    if ((ac = Argify(vec)) == 1 && EQ(vec[0], "fi"))
X		break;
X	    if (EQ(vec[0], "else")) {
X		DoUntil("fi", FALSE);
X		break;
X	    }
X	    (void)Exec(vec);
X	}
X    }
X    else
X	while (GetLine(TRUE)) {
X	    if ((ac = Argify(vec)) == 1 && EQ(vec[0], "fi"))
X		break;
X	    if (EQ(vec[0], "else")) {
X		if (ac > 1)
X		    (void)Exec(&vec[1]);
X		DoUntil("fi", Running);
X		break;
X	    }
X	}
X    return(TRUE);
X}
X
X
X/*
X**  Do a FOR statement.
X*/
Xstatic int
XDoFOR(ac, av)
X    REGISTER int	  ac;
X    REGISTER char	 *av[];
X{
X    REGISTER char	 *Var;
X    REGISTER char	**Values;
X    REGISTER int	  Found;
X    long		  Here;
X    char		 *vec[MAX_WORDS];
X
X    /* Check usage, get variable name and eat noise words. */
X    if (ac < 4 || !EQ(av[2], "in"))
X	SynErr("FOR");
X    Var = av[1];
X    ac -= 3;
X    av += 3;
X
X    /* Look for "; do" on this line, or just "do" on next line. */
X    for (Values = av; *++av; )
X	if (Found = EQ(*av, ";")) {
X	    if (av[1] == NULL || !EQ(av[1], "do"))
X		SynErr("FOR");
X	    *av = NULL;
X	    break;
X	}
X    if (!Found) {
X	(void)GetLine(TRUE);
X	if (Argify(vec) != 1 || !EQ(vec[0], "do"))
X	    SynErr("FOR (missing DO)");
X    }
X
X    for (Here = ftell(Input); *Values; ) {
X	SetVar(Var, *Values);
X	DoUntil("done", Running);
X	    ;
X	/* If we're not Running, only go through the loop once. */
X	if (!Running)
X	    break;
X	if (*++Values && (fseek(Input, Here, 0) < 0 || ftell(Input) != Here))
X	    SynErr("FOR (can't seek back)");
X    }
X
X    return(TRUE);
X}
X
X
X/*
X**  Do a CASE statement of the form:
X**	case $var in
X**	    text1)
X**		...
X**		;;
X**	esac
X**  Where text1 is a simple word or an asterisk.
X*/
Xstatic int
XDoCASE(ac, av)
X    REGISTER int	 ac;
X    REGISTER char	*av[];
X{
X    REGISTER int	 FoundIt;
X    char		*vec[MAX_WORDS];
X    char		 Value[VAR_VALUE_SIZE];
X
X    if (ac != 3 || !EQ(av[2], "in"))
X	SynErr("CASE");
X    (void)strcpy(Value, Expand(av[1]));
X
X    for (FoundIt = FALSE; GetLine(TRUE); ) {
X	ac = Argify(vec);
X	if (EQ(vec[0], "esac"))
X	    break;
X	/* This is for vi: (-; sigh. */
X	if (ac != 2 || !EQ(vec[1], ")"))
X	    SynErr("CASE");
X	if (!FoundIt && (EQ(vec[0], Value) || EQ(vec[0], "*"))) {
X	    FoundIt = TRUE;
X	    if (Running && ac > 2)
X		(void)Exec(&vec[2]);
X	    DoUntil(";;", Running);
X	}
X	else
X	    DoUntil(";;", FALSE);
X    }
X    return(TRUE);
X}
X
X
X
X/*
X**  Dispatch table of known commands.
X*/
Xstatic COMTAB	 Dispatch[] = {
X    {	"cat",		DoCAT		},
X    {	"case",		DoCASE		},
X    {	"cd",		DoCD		},
X    {	"chdir",	DoCD		},
X    {	"chmod",	DoIT		},
X    {	"cp",		DoCP		},
X    {	"echo",		DoECHO		},
X    {	"exit",		DoEXIT		},
X    {	"export",	DoEXPORT	},
X    {	"for",		DoFOR		},
X    {	"if",		DoIF		},
X    {	"mkdir",	DoMKDIR		},
X    {	"rm",		DoIT		},
X    {	"sed",		DoSED		},
X    {	"test",		DoTEST		},
X    {	"[",		DoTEST		},
X    {	":",		DoIT		},
X    {	"",		NULL		}
X};
X
X
X/*
X**  Dispatch on a parsed line.
X*/
Xint
XExec(av)
X    REGISTER char	*av[];
X{
X    REGISTER int	 i;
X    REGISTER COMTAB	*p;
X
X    /* We have to re-calculate this because our callers can't always
X       pass the count down to us easily. */
X    for (i = 0; av[i]; i++)
X	;
X    if (i) {
X	/* Is this a command we know? */
X	for (p = Dispatch; p->Func; p++)
X	    if (EQ(av[0], p->Name)) {
X		i = (*p->Func)(i, av);
X		if (p->Func == DoEXIT)
X		    /* Sigh; this is a hack. */
X		    return(-FALSE);
X		break;
X	    }
X
X	/* If not a command, try it as a variable assignment. */
X	if (p->Func == NULL)
X	    /* Yes, we look for "=" in the first word, but pass down
X	       the whole line. */
X	    if (IDX(av[0], '='))
X		DoASSIGN(Text);
X	    else
X		Note("Command %s unknown.\n", av[0]);
X
X	/* Free the line. */
X	for (i = 0; av[i]; i++)
X	    free(av[i]);
X    }
X    return(TRUE);
X}
X
X
X/*
X**  Do until we reach a specific terminator.
X*/
Xstatic
XDoUntil(Terminator, NewVal)
X    char	*Terminator;
X    int		 NewVal;
X{
X    char	*av[MAX_WORDS];
X    int		 OldVal;
X
X    for (OldVal = Running, Running = NewVal; GetLine(TRUE); )
X	if (Argify(av)) {
X	    if (EQ(av[0], Terminator))
X		break;
X	    (void)Exec(av);
X	}
X
X    Running = OldVal;
X}
END_OF_FILE
if test 24180 -ne `wc -c <'parser.c'`; then
    echo shar: \"'parser.c'\" unpacked with wrong size!
fi
# end of 'parser.c'
fi
echo shar: End of archive 3 \(of 3\).
cp /dev/null ark3isdone
MISSING=""
for I in 1 2 3 ; do
    if test ! -f ark${I}isdone ; then
	MISSING="${MISSING} ${I}"
    fi
done
if test "${MISSING}" = "" ; then
    echo You have unpacked all 3 archives.
    rm -f ark[1-9]isdone
else
    echo You still need to unpack the following archives:
    echo "        " ${MISSING}
fi
##  End of shell archive.
exit 0
