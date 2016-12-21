#! /bin/sh
# This is a shell archive.  Remove anything before this line, then unpack
# it by saving it into a file and typing "sh file".  To overwrite existing
# files, type "sh file -c".  You can also feed this as standard input via
# unshar, or by typing "sh <file", e.g..  If this archive is complete, you
# will see the following message at the end:
#		"End of archive 2 (of 3)."
# Contents:  config.h dir.amiga dir.msdos findsrc.c makekit.man shar.c
#   unshar.c
# Wrapped by yaya@blondie on Wed Dec 21 00:58:24 2016
PATH=/bin:/usr/bin:/usr/ucb ; export PATH
if test -f 'config.h' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'config.h'\"
else
echo shar: Extracting \"'config.h'\" \(4517 characters\)
sed "s/^X//" >'config.h' <<'END_OF_FILE'
X/*
X**  Configuration file for shar and friends.
X**
X**  This is known to work on Ultrix1.2 and Sun3.4 machines; it may work
X**  on other BSD variants, too.
X**
X**  $Header: /Users/yaya/ccshar/RCS/config.h,v 1.2 2005/11/26 03:02:13 yaya Exp yaya $
X*/
X
X
X/*
X**  Higher-level controls for which operating system we're running on.
X*/
X#define UNIX				/* Works			*/
X/*efine MSDOS				/* Should work			*/
X/*efine VMS				/* Doesn't work			*/
X
X
X/*
X**  A dense section of one-line compilation controls.  If you're confused,
X**  your best bet is to search through the source to see where and how
X**  each one of these is used.
X*/
X#define IDX		index		/* Maybe strchr?		*/
X#define RDX		rindex		/* Maybe strrchr?		*/
X/*efine NEED_MKDIR			/* Don't have mkdir(2)?		*/
X/*efine NEED_QSORT			/* Don't have qsort(3)?		*/
X/*efine NEED_RENAME			/* Don't have rename(2 or 3)?	*/
X#define NEED_GETOPT			/* Need local getopt object?	*/
X#define CAN_POPEN			/* Can invoke file(1) command?	*/
X/*efine USE_MY_SHELL			/* Don't popen("/bin/sh")?	*/
X/*efine BACKUP_PREFIX	"B-"		/* Instead of ".BAK" suffix?	*/
Xtypedef void		 sigret_t;	/* What a signal handler returns */
Xtypedef int		*align_t;	/* Worst-case alignment, for lint */
X/* typedef long		time_t		/* Needed for non-BSD sites?	*/
X/* typedef long		off_t		/* Needed for non-BSD sites?	*/
X/*efine void		int		/* If you don't have void	*/
X/*efine SYS_WAIT			/* Have <sys/wait.h> and vfork?	*/
X/*efine USE_SYSTEM			/* Use system(3), not exec(2)?	*/
X/*efine USE_SYSERRLIST			/* Have sys_errlist[], sys_nerr? */
X#define USE_GETPWUID			/* Use getpwuid(3)?		*/
X#define DEF_SAVEIT	1		/* Save headers by default?	*/
X/*efine FMT02d				/* Need "%02.2d", not "%2.2d"?	*/
X#define MAX_LEVELS	6		/* Levels for findsrc to walk	*/
X#define THE_TTY		"/dev/tty"	/* Maybe "con:" for MS-DOS?	*/
X#define RCSID				/* Compile in the RCS strings?	*/
X#define USERNAME	"USER"		/* Your name, if not in environ	*/
X/*efine PTR_SPRINTF			/* Need extern char *sprinf()?	*/
X/*efine ANSI_HDRS			/* Use <stdlib.h>, etc.?	*/
X#define REGISTER	register	/* Do you trust your compiler?	*/
X#define HAVE_UNISTD	1		/* Do you have unistd.h         */
X#define HAVE_STRING	1		/* Do you have string.h         */ 
X#define HAVE_STDLIB	1		/* Do you have stdlib.h         */
X#define HAVE_ERRNO	1		/* Do you have errno.h          */
X/*
X**  There are several ways to get current machine name.  Enable just one
X**  of one of the following lines.
X*/
X#define GETHOSTNAME			/* Use gethostname(2) call	*/
X/*efine UNAME				/* Use uname(2) call		*/
X/*efine UUNAME				/* Invoke "uuname -l"		*/
X/*efine	WHOAMI				/* Try /etc/whoami & <whoami.h>	*/
X/*efine HOST		"SITE"		/* If all else fails		*/
X
X
X/*
X**  There are several different ways to get the current working directory.
X**  Enable just one of the following lines.
X*/
X#define GETWD				/* Use getwd(3) routine		*/
X/*efine GETCWD				/* Use getcwd(3) routine	*/
X/*efine PWDPOPEN			/* Invoke "pwd"			*/
X/*efine PWDGETENV	"PWD"		/* Get $PWD from environment	*/
X
X
X/*
X**  If you're a notes site, you might have to tweaks these two #define's.
X**  If you don't care, then set them equal to something that doesn't
X**  start with the comment-begin sequence and they'll be effectively no-ops
X**  at the cost of an extra strcmp.  I've also heard of broken MS-DOS
X**  compilers that don't ignore slash-star inside comments!  Anyhow, for
X**  more details see unshar.c
X*/
X/*efine NOTES1		"/* Written "	/* This is what notes 1.7 uses	*/
X/*efine NOTES2		"/* ---"	/* This is what notes 1.7 uses	*/
X#define NOTES1		"$$"		/* This is a don't care		*/
X#define NOTES2		"$$"		/* This is a don't care		*/
X
X
X/*
X**  The findsrc program uses the readdir() routines to read directories.
X**  If your system doesn't have this interface, there are public domain
X**  implementations available for Unix from the comp.sources.unix archives,
X**  GNU has a VMS one inside EMACS, and this package comes with kits for
X**  MS-DOS and the Amiga.  Help save the world and use or write a readdir()
X**  package for your system!
X*/
X
X/* Now then, where did I put that header file?   Pick one. */
X/*efine IN_SYS_DIR			/* <sys/dir.h>			*/
X/*efine IN_SYS_NDIR			/* <sys/ndir.h>			*/
X/*efine IN_DIR				/* <dir.h>			*/
X/*efine IN_DIRECT			/* <direct.h>			*/
X/*efine IN_NDIR				/* "ndir.h"			*/
X#define IN_DIRENT			/* <dirent.h>			*/
X
X/*  What readdir() returns.  Must be a #define because of #include order. */
X#ifdef	IN_DIRENT
X#define DIRENTRY	struct dirent
X#else
X#define DIRENTRY	struct direct
X#endif	/* IN_DIRENT */
X
X/*
X**  Congratulations, you're done!
X*/
END_OF_FILE
if test 4517 -ne `wc -c <'config.h'`; then
    echo shar: \"'config.h'\" unpacked with wrong size!
fi
# end of 'config.h'
fi
if test -f 'dir.amiga' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'dir.amiga'\"
else
echo shar: Extracting \"'dir.amiga'\" \(6596 characters\)
sed "s/^X//" >'dir.amiga' <<'END_OF_FILE'
X
X[  I have not tried this at all.  --r$  ]
X
XReturn-Path: mwm@violet.Berkeley.EDU
XReceived: from violet.berkeley.edu (violet.berkeley.edu.ARPA) by PINEAPPLE.BBN.COM (4.12/4.7)  id AA28194; Tue, 14 Jul 87 00:52:17 edt
XReceived: from localhost.ARPA
X	by violet.berkeley.edu (5.54 (CFC 4.22.3)/1.16.15)
X	id AA16462; Mon, 13 Jul 87 21:54:26 PDT
XMessage-Id: <8707140454.AA16462@violet.berkeley.edu>
XTo: Richard Salz <rsalz@pineapple.bbn.com>
XSubject: Re: Amiga version of the dir library... 
XUltrix: Just say No!
XIn-Reply-To: Your message of Wed, 08 Jul 87 21:19:51 -0400
XDate: Mon, 13 Jul 87 21:54:25 PDT
XFrom: Mike (My watch has windows) Meyer <mwm@violet.Berkeley.EDU>
X
XHere's what I did. This is built to reflect the 4BSD manual pages, not
Xthe SysV/dpANS manual pages.
X
XI now know how to get the telldir/seekdir pair to work correctly with
Xmultiple tell()s, but don't have much motivation to do so. If someone
Xout there does it, or is interested in doing it, I'd be interested in
Xthe results or willing to help.
X
XFinal note: as with many micros, there's more than one C compiler.
XThis was written for the Lattice compiler, and uses features known
Xnot to exist in other Amiga compilers. Fixing it should be trivial.
X
XOh, yeah - sorry for the delay in getting these two you.
X
X	<mike
X
X#! /bin/sh
X# This is a shell archive, meaning:
X# 1. Remove everything above the #! /bin/sh line.
X# 2. Save the resulting text in a file.
X# 3. Execute the file with /bin/sh (not csh) to create:
X#	dir.h
X#	ndir.c
X# By:	Mike (My watch has windows) Meyer (Missionaria Phonibalonica)
Xexport PATH; PATH=/bin:/usr/bin:$PATH
Xecho shar: "extracting 'dir.h'" '(1708 characters)'
Xif test -f 'dir.h'
Xthen
X	echo shar: "will not over-write existing file 'dir.h'"
Xelse
Xsed 's/^X//' << \SHAR_EOF > 'dir.h'
XX#ifndef DIR_H
XX#define DIR_H
XX
XX#ifndef	EXEC_TYPES_H
XX#include "exec/types.h"
XX#endif
XX
XX#ifndef	LIBRARIES_DOS_H
XX#include "libraries/dos.h"
XX#endif
XX
XX#ifndef	LIBRARIES_DOSEXTENS_H
XX#include "libraries/dosextens.h"
XX#endif
XX/*
XX * MAXNAMELEN is the maximum length a file name can be. The direct structure
XX * is lifted form 4BSD, and has not been changed so that code which uses
XX * it will be compatable with 4BSD code. d_ino and d_reclen are unused,
XX * and will probably be set to some non-zero value.
XX */
XX#define	MAXNAMLEN	31		/* AmigaDOS file max length */
XX
XXstruct	direct {
XX	ULONG	d_ino ;			/* unused - there for compatability */
XX	USHORT	d_reclen ;		/* ditto */
XX	USHORT	d_namlen ;		/* length of string in d_name */
XX	char	d_name[MAXNAMLEN + 1] ;	/* name must be no longer than this */
XX};
XX/*
XX * The DIRSIZ macro gives the minimum record length which will hold
XX * the directory entry.  This requires the amount of space in struct direct
XX * without the d_name field, plus enough space for the name with a terminating
XX * null byte (dp->d_namlen+1), rounded up to a 4 byte boundary.
XX */
XX
XX#undef DIRSIZ
XX#define DIRSIZ(dp) \
XX    ((sizeof(struct direct) - (MAXNAMLEN+1)) + (((dp) -> d_namlen+1 + 3) &~ 3))
XX/*
XX * The DIR structure holds the things that AmigaDOS needs to know about
XX * a file to keep track of where it is and what it's doing.
XX */
XX
XXtypedef struct {
XX	struct FileInfoBlock	d_info ,	/* Default info block */
XX				d_seek ;	/* Info block for seeks */
XX	struct FileLock		*d_lock ;	/* Lock on directory */
XX	} DIR ;
XX	
XXextern	DIR *opendir(char *) ;
XXextern	struct direct *readdir(DIR *) ;
XXextern	long telldir(DIR *) ;
XXextern	void seekdir(DIR *, long) ;
XXextern	void rewinddir(DIR *) ;
XXextern	void closedir(DIR *) ;
XX#endif	DIR_H
XSHAR_EOF
Xif test 1708 -ne "`wc -c < 'dir.h'`"
Xthen
X	echo shar: "error transmitting 'dir.h'" '(should have been 1708 characters)'
Xfi
Xfi
Xecho shar: "extracting 'ndir.c'" '(2486 characters)'
Xif test -f 'ndir.c'
Xthen
X	echo shar: "will not over-write existing file 'ndir.c'"
Xelse
Xsed 's/^X//' << \SHAR_EOF > 'ndir.c'
XX/*
XX * ndir - routines to simulate the 4BSD new directory code for AmigaDOS.
XX */
XX#include <dir.h>
XX
XXDIR *
XXopendir(dirname) char *dirname; {
XX	register DIR	*my_dir, *AllocMem(int, int) ;
XX	struct FileLock	*Lock(char *, int), *CurrentDir(struct FileLock *) ;
XX
XX	if ((my_dir = AllocMem(sizeof(DIR), 0)) == NULL) return NULL ;
XX
XX
XX	if (((my_dir -> d_lock = Lock(dirname, ACCESS_READ)) == NULL)
XX	/* If we can't examine it */
XX	||  !Examine(my_dir -> d_lock, &(my_dir -> d_info))
XX	/* Or it's not a directory */
XX	||  (my_dir -> d_info . fib_DirEntryType < 0)) {
XX		FreeMem(my_dir, sizeof(DIR)) ;
XX		return NULL ;
XX		}
XX	return my_dir ;
XX	}
XX
XXstruct direct *
XXreaddir(my_dir) DIR *my_dir; {
XX	static struct direct	result ;
XX
XX	if (!ExNext(my_dir -> d_lock, &(my_dir -> d_info))) return NULL ;
XX
XX	result . d_reclen = result . d_ino = 1 ;	/* Not NULL! */
XX	(void) strcpy(result . d_name, my_dir -> d_info . fib_FileName) ;
XX	result . d_namlen = strlen(result . d_name) ;
XX	return &result ;
XX	}
XX
XXvoid
XXclosedir(my_dir) DIR *my_dir; {
XX
XX	UnLock(my_dir -> d_lock) ;
XX	FreeMem(my_dir, sizeof(DIR)) ;
XX	}
XX/*
XX * telldir and seekdir don't work quite right. The problem is that you have
XX * to save more than a long's worth of stuff to indicate position, and it's
XX * socially unacceptable to alloc stuff that you don't free later under
XX * AmigaDOS. So we fake it - you get one level of seek, and dat's all.
XX * As of now, these things are untested.
XX */
XX#define DIR_SEEK_RETURN		((long) 1)	/* Not 0! */
XXlong
XXtelldir(my_dir) DIR *my_dir; {
XX
XX	my_dir -> d_seek = my_dir -> d_info ;
XX	return (long) DIR_SEEK_RETURN ;
XX	}
XX
XXvoid
XXseekdir(my_dir, where) DIR *my_dir; long where; {
XX
XX	if (where == DIR_SEEK_RETURN)
XX		my_dir -> d_info = my_dir -> d_seek ;
XX	else	/* Makes the next readdir fail */
XX		setmem((char *) my_dir, sizeof(DIR), 0) ;
XX	}
XX
XXvoid
XXrewinddir(my_dir) DIR *my_dir; {
XX
XX	if (!Examine(my_dir -> d_lock, &(my_dir -> d_info)))
XX		setmem((char *) my_dir, sizeof(DIR), 0) ;
XX	}
XX#ifdef	TEST
XX/*
XX * Simple code to list the files in the argument directory,
XX *	lifted straight from the man page.
XX */
XX#include <stdio.h>
XXvoid
XXmain(argc, argv) int argc; char **argv; {
XX	register DIR		*dirp ;
XX	register struct direct	*dp ;
XX	register char		*name ;
XX
XX	if (argc < 2) name = "" ;
XX	else name = argv[1] ;
XX
XX	if ((dirp = opendir(name)) == NULL) {
XX		fprintf(stderr, "Bogus! Can't opendir %s\n", name) ;
XX		exit(1) ;
XX		}
XX
XX	for (dp = readdir(dirp); dp != NULL; dp = readdir(dirp))
XX		printf("%s ", dp -> d_name) ;
XX	closedir(dirp);
XX	putchar('\n') ;
XX	}
XX#endif	TEST
XX
XSHAR_EOF
Xif test 2486 -ne "`wc -c < 'ndir.c'`"
Xthen
X	echo shar: "error transmitting 'ndir.c'" '(should have been 2486 characters)'
Xfi
Xfi
Xexit 0
X#	End of shell archive
END_OF_FILE
if test 6596 -ne `wc -c <'dir.amiga'`; then
    echo shar: \"'dir.amiga'\" unpacked with wrong size!
fi
# end of 'dir.amiga'
fi
if test -f 'dir.msdos' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'dir.msdos'\"
else
echo shar: Extracting \"'dir.msdos'\" \(6547 characters\)
sed "s/^X//" >'dir.msdos' <<'END_OF_FILE'
X#! /bin/sh
X# This is a shell archive.  Remove anything before this line, then unpack
X# it by saving it into a file and typing "sh file".  To overwrite existing
X# files, type "sh file -c".  You can also feed this as standard input via
X# unshar, or by typing "sh <file", e.g..  If this archive is complete, you
X# will see the following message at the end:
X#		"End of shell archive."
X# Contents:  msd_dir.c msd_dir.h
X# Wrapped by rsalz@fig.bbn.com on Thu May 26 16:06:31 1988
XPATH=/bin:/usr/bin:/usr/ucb ; export PATH
Xif test -f 'msd_dir.c' -a "${1}" != "-c" ; then 
X  echo shar: Will not clobber existing file \"'msd_dir.c'\"
Xelse
Xecho shar: Extracting \"'msd_dir.c'\" \(4114 characters\)
Xsed "s/^X//" >'msd_dir.c' <<'END_OF_FILE'
XX/*
XX * @(#)msd_dir.c 1.4 87/11/06	Public Domain.
XX *
XX *  A public domain implementation of BSD directory routines for
XX *  MS-DOS.  Written by Michael Rendell ({uunet,utai}michael@garfield),
XX *  August 1897
XX */
XX
XX#include	<sys/types.h>
XX#include	<sys/stat.h>
XX#include	<sys/dir.h>
XX#include	<malloc.h>
XX#include	<string.h>
XX#include	<dos.h>
XX
XX#ifndef	NULL
XX# define	NULL	0
XX#endif	/* NULL */
XX
XX#ifndef	MAXPATHLEN
XX# define	MAXPATHLEN	255
XX#endif	/* MAXPATHLEN */
XX
XX/* attribute stuff */
XX#define	A_RONLY		0x01
XX#define	A_HIDDEN	0x02
XX#define	A_SYSTEM	0x04
XX#define	A_LABEL		0x08
XX#define	A_DIR		0x10
XX#define	A_ARCHIVE	0x20
XX
XX/* dos call values */
XX#define	DOSI_FINDF	0x4e
XX#define	DOSI_FINDN	0x4f
XX#define	DOSI_SDTA	0x1a
XX
XX#define	Newisnull(a, t)		((a = (t *) malloc(sizeof(t))) == (t *) NULL)
XX#define	ATTRIBUTES		(A_DIR | A_HIDDEN | A_SYSTEM)
XX
XX/* what find first/next calls look use */
Xtypedef struct {
XX	char		d_buf[21];
XX	char		d_attribute;
XX	unsigned short	d_time;
XX	unsigned short	d_date;
XX	long		d_size;
XX	char		d_name[13];
XX} Dta_buf;
XX
Xstatic	char	*getdirent();
Xstatic	void	setdta();
Xstatic	void	free_dircontents();
XX
Xstatic	Dta_buf		dtabuf;
Xstatic	Dta_buf		*dtapnt = &dtabuf;
Xstatic	union REGS	reg, nreg;
XX
XX#if	defined(M_I86LM)
Xstatic	struct SREGS	sreg;
XX#endif
XX
XDIR	*
Xopendir(name)
XX	char	*name;
XX{
XX	struct	stat		statb;
XX	DIR			*dirp;
XX	char			c;
XX	char			*s;
XX	struct _dircontents	*dp;
XX	char			nbuf[MAXPATHLEN + 1];
XX	
XX	if (stat(name, &statb) < 0 || (statb.st_mode & S_IFMT) != S_IFDIR)
XX		return (DIR *) NULL;
XX	if (Newisnull(dirp, DIR))
XX		return (DIR *) NULL;
XX	if (*name && (c = name[strlen(name) - 1]) != '\\' && c != '/')
XX		(void) strcat(strcpy(nbuf, name), "\\*.*");
XX	else
XX		(void) strcat(strcpy(nbuf, name), "*.*");
XX	dirp->dd_loc = 0;
XX	setdta();
XX	dirp->dd_contents = dirp->dd_cp = (struct _dircontents *) NULL;
XX	if ((s = getdirent(nbuf)) == (char *) NULL)
XX		return dirp;
XX	do {
XX		if (Newisnull(dp, struct _dircontents) || (dp->_d_entry =
XX			malloc((unsigned) (strlen(s) + 1))) == (char *) NULL)
XX		{
XX			if (dp)
XX				free((char *) dp);
XX			free_dircontents(dirp->dd_contents);
XX			return (DIR *) NULL;
XX		}
XX		if (dirp->dd_contents)
XX			dirp->dd_cp = dirp->dd_cp->_d_next = dp;
XX		else
XX			dirp->dd_contents = dirp->dd_cp = dp;
XX		(void) strcpy(dp->_d_entry, s);
XX		dp->_d_next = (struct _dircontents *) NULL;
XX	} while ((s = getdirent((char *) NULL)) != (char *) NULL);
XX	dirp->dd_cp = dirp->dd_contents;
XX
XX	return dirp;
XX}
XX
Xvoid
Xclosedir(dirp)
XX	DIR	*dirp;
XX{
XX	free_dircontents(dirp->dd_contents);
XX	free((char *) dirp);
XX}
XX
Xstruct direct	*
Xreaddir(dirp)
XX	DIR	*dirp;
XX{
XX	static	struct direct	dp;
XX	
XX	if (dirp->dd_cp == (struct _dircontents *) NULL)
XX		return (struct direct *) NULL;
XX	dp.d_namlen = dp.d_reclen =
XX		strlen(strcpy(dp.d_name, dirp->dd_cp->_d_entry));
XX	dp.d_ino = 0;
XX	dirp->dd_cp = dirp->dd_cp->_d_next;
XX	dirp->dd_loc++;
XX
XX	return &dp;
XX}
XX
Xvoid
Xseekdir(dirp, off)
XX	DIR	*dirp;
XX	long	off;
XX{
XX	long			i = off;
XX	struct _dircontents	*dp;
XX
XX	if (off < 0)
XX		return;
XX	for (dp = dirp->dd_contents ; --i >= 0 && dp ; dp = dp->_d_next)
XX		;
XX	dirp->dd_loc = off - (i + 1);
XX	dirp->dd_cp = dp;
XX}
XX
Xlong
Xtelldir(dirp)
XX	DIR	*dirp;
XX{
XX	return dirp->dd_loc;
XX}
XX
Xstatic	void
Xfree_dircontents(dp)
XX	struct	_dircontents	*dp;
XX{
XX	struct _dircontents	*odp;
XX
XX	while (dp) {
XX		if (dp->_d_entry)
XX			free(dp->_d_entry);
XX		dp = (odp = dp)->_d_next;
XX		free((char *) odp);
XX	}
XX}
XX
Xstatic	char	*
Xgetdirent(dir)
XX	char	*dir;
XX{
XX	if (dir != (char *) NULL) {		/* get first entry */
XX		reg.h.ah = DOSI_FINDF;
XX		reg.h.cl = ATTRIBUTES;
XX#if	defined(M_I86LM)
XX		reg.x.dx = FP_OFF(dir);
XX		sreg.ds = FP_SEG(dir);
XX#else
XX		reg.x.dx = (unsigned) dir;
XX#endif
XX	} else {				/* get next entry */
XX		reg.h.ah = DOSI_FINDN;
XX#if	defined(M_I86LM)
XX		reg.x.dx = FP_OFF(dtapnt);
XX		sreg.ds = FP_SEG(dtapnt);
XX#else
XX		reg.x.dx = (unsigned) dtapnt;
XX#endif
XX	}
XX#if	defined(M_I86LM)
XX	intdosx(&reg, &nreg, &sreg);
XX#else
XX	intdos(&reg, &nreg);
XX#endif
XX	if (nreg.x.cflag)
XX		return (char *) NULL;
XX
XX	return dtabuf.d_name;
XX}
XX
Xstatic	void
Xsetdta()
XX{
XX	reg.h.ah = DOSI_SDTA;
XX#if	defined(M_I86LM)
XX	reg.x.dx = FP_OFF(dtapnt);
XX	sreg.ds = FP_SEG(dtapnt);
XX	intdosx(&reg, &nreg, &sreg);
XX#else
XX	reg.x.dx = (int) dtapnt;
XX	intdos(&reg, &nreg);
XX#endif
XX}
XEND_OF_FILE
Xif test 4114 -ne `wc -c <'msd_dir.c'`; then
X    echo shar: \"'msd_dir.c'\" unpacked with wrong size!
Xfi
X# end of 'msd_dir.c'
Xfi
Xif test -f 'msd_dir.h' -a "${1}" != "-c" ; then 
X  echo shar: Will not clobber existing file \"'msd_dir.h'\"
Xelse
Xecho shar: Extracting \"'msd_dir.h'\" \(954 characters\)
Xsed "s/^X//" >'msd_dir.h' <<'END_OF_FILE'
XX/*
XX * @(#)msd_dir.h 1.4 87/11/06	Public Domain.
XX *
XX *  A public domain implementation of BSD directory routines for
XX *  MS-DOS.  Written by Michael Rendell ({uunet,utai}michael@garfield),
XX *  August 1897
XX */
XX
XX#define	rewinddir(dirp)	seekdir(dirp, 0L)
XX
XX#define	MAXNAMLEN	12
XX
Xstruct direct {
XX	ino_t	d_ino;			/* a bit of a farce */
XX	int	d_reclen;		/* more farce */
XX	int	d_namlen;		/* length of d_name */
XX	char	d_name[MAXNAMLEN + 1];		/* garentee null termination */
XX};
XX
Xstruct _dircontents {
XX	char	*_d_entry;
XX	struct _dircontents	*_d_next;
XX};
XX
Xtypedef struct _dirdesc {
XX	int		dd_id;	/* uniquely identify each open directory */
XX	long		dd_loc;	/* where we are in directory entry is this */
XX	struct _dircontents	*dd_contents;	/* pointer to contents of dir */
XX	struct _dircontents	*dd_cp;	/* pointer to current position */
XX} DIR;
XX
Xextern	DIR		*opendir();
Xextern	struct direct	*readdir();
Xextern	void		seekdir();
Xextern	long		telldir();
Xextern	void		closedir();
XEND_OF_FILE
Xif test 954 -ne `wc -c <'msd_dir.h'`; then
X    echo shar: \"'msd_dir.h'\" unpacked with wrong size!
Xfi
X# end of 'msd_dir.h'
Xfi
Xecho shar: End of shell archive.
Xexit 0
END_OF_FILE
if test 6547 -ne `wc -c <'dir.msdos'`; then
    echo shar: \"'dir.msdos'\" unpacked with wrong size!
fi
# end of 'dir.msdos'
fi
if test -f 'findsrc.c' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'findsrc.c'\"
else
echo shar: Extracting \"'findsrc.c'\" \(7225 characters\)
sed "s/^X//" >'findsrc.c' <<'END_OF_FILE'
X/*
X**  FINDSRC
X**  Walk directories, trying to find source files.
X*/
X#include "shar.h"
X#ifdef	RCSID
Xstatic char RCS[] =
X	"$Header: /Users/yaya/ccshar/RCS/findsrc.c,v 1.1 2005/08/03 02:31:07 root Exp root $";
X#endif	/* RCSID */
X
X
X/*
X**  Global variables.
X*/
Xint	 DoDOTFILES;			/* Do .newsrc and friends?	*/
Xint	 DoRCS;				/* Do RCS and SCCS files?	*/
Xint	 Default;			/* Default answer from user	*/
Xint	 Verbose;			/* List rejected files, too?	*/
Xstatic char	Dname[22];				/* Filename of directory list	*/
Xstatic char	Fname[22];				/* Filename of file list	*/
XFILE	*Dfile;				/* List of directories found	*/
XFILE	*Ffile;				/* List of files found		*/
XFILE	*DEVTTY;			/* The tty, if in filter mode	*/
X
X
X/*
X**  Signal handler.  Clean up and die.
X*/
Xstatic sigret_t
XCatch(int s)
X{
X    int		 e;
X
X    e = errno;
X    if (Dname)
X	(void)unlink(Dname);
X    if (Fname)
X    (void)unlink(Fname);
X    Fprintf(stderr, "Got signal %d, %s.\n", s, Ermsg(e));
X    exit(1);
X}
X
X
X/*
X**  Given a filename, apply heuristics to see if we want it.
X*/
Xstatic int
XWanted(char *Name)
X{
X    REGISTER FILE	*F;
X    REGISTER char	*s;
X    REGISTER char	*p;
X    REGISTER char	*d;
X    char		 buff[BUFSIZ];
X
X    /* Get down to brass tacks. */
X    s = (p = RDX(Name, '/')) ? p + 1 : Name;
X
X    /* Only do directories other than . and .. and regular files. */
X    if ((Ftype(Name) != F_DIR && Ftype(Name) != F_FILE)
X     || EQ(s, ".") || EQ(s, ".."))
X	return(FALSE);
X
X    /* Common cruft we never want. */
X    if (EQ(s, "foo") || EQ(s, "core") || EQ(s, "tags") || EQ(s, "lint"))
X	return(FALSE);
X
X    /* Disregard stuff with bogus suffixes. */
X    d = RDX(s, '.');
X    if ((p = d)
X     && (EQ(++p, "out") || EQ(p, "orig") || EQ(p, "rej") || EQ(p, "BAK")
X      || EQ(p, "CKP") || EQ(p, "old") || EQ(p, "o") || EQ(p, "EXE")
X      || EQ(p, "OBJ")))
X	return(FALSE);
X
X    /* Want .cshrc, .newsrc, etc.? */
X    if (*s == '.' && isascii(s[1]) && isalpha(s[1]))
X	return(DoDOTFILES);
X
X    /* RCS or SCCS file or directory? */
X    if (EQ(s, "RCS")
X     || ((p = RDX(s, ',')) && *++p == 'v' && *++p == '\0')
X     || EQ(s, "SCCS") || (s[0] == 's' && s[1] == '.'))
X	return(DoRCS);
X
X    /* Mlisp, m4 (yes to .m? but no to .mo)? */
X    /* really, no to .mo but yes to names matching the regexp ".m?" */
X    if ((p = d) && *++p == 'm' && p[2] == '\0')
X	return(*++p != 'o');
X
X    /* Gnu Emacs elisp (yes to .el*, but no to .elc)? */
X    if ((p = d) && *++p == 'e' && *++p == 'l')
X	return(*++p != 'c' || *++p);
X
X    /* C source (*.[ch])? */
X    if ((p = d) && (*++p == 'c' || *p == 'h') && *++p == '\0')
X	return(TRUE);
X
X    /* Manpage (*.[1234567890] or *.man)? */
X    if ((p = d) && isascii(s[1]) && isdigit(*p))
X	return(TRUE);
X    if ((p = d) && *++p == 'm' && *++p == 'a' && *++p == 'n')
X	return(TRUE);
X
X    /* Make control file? */
X    if ((*s == 'M' || *s == 'm') && EQ(s + 1, "akefile"))
X	return(TRUE);
X
X    /* Convert to lowercase, and see if it's a README or MANIFEST. */
X    for (p = strcpy(buff, s); *p; p++)
X	if (isascii(*p) && isupper(*p))
X	    *p = tolower(*p);
X    if (EQ(buff, "readme") || EQ(buff, "read_me") || EQ(buff, "read-me")
X     || EQ(buff, "manifest"))
X	return(TRUE);
X
X    /* Larry Wall-style template file (*.SH)? */
X    if ((p = d) && *++p == 'S' && *++p == 'H')
X	return(TRUE);
X
X    /* If we have a default, give it back. */
X    if (Default)
X	return(Default == 'y');
X
X#ifdef	CAN_POPEN
X    /* See what file(1) has to say; if it says executable, punt. */
X    (void)sprintf(buff, "exec file '%s'", Name);
X    if (F = popen(buff, "r")) {
X	(void)fgets(buff, sizeof buff, F);
X	(void)pclose(F);
X	for (p = buff; p = IDX(p, 'e'); p++)
X	    if (PREFIX(p, "executable"))
X		return(FALSE);
X	(void)fputs(buff, stderr);
X    }
X#endif	/* CAN_POPEN */
X
X    /* Add it? */
X    while (TRUE) {
X	if (DEVTTY == NULL)
X	    DEVTTY = fopen(THE_TTY, "r");
X	Fprintf(stderr, "Add this one (y or n)[y]?  ");
X	(void)fflush(stderr);
X	if (fgets(buff, sizeof buff, DEVTTY) == NULL
X	 || buff[0] == '\n' || buff[0] == 'y' || buff[0] == 'Y')
X	    break;
X	if (buff[0] == 'n' || buff[0] == 'N')
X	    return(FALSE);
X	if (buff[0] == '!' )
X	    (void)system(&buff[1]);
X	Fprintf(stderr, "--------------------\n%s:  ", Name);
X	clearerr(DEVTTY);
X    }
X    return(TRUE);
X}
X
X
X/*
X**  Quick and dirty recursive routine to walk down directory tree.
X**  Could be made more general, but why bother?
X*/
Xstatic void
XProcess(char *p, int level)
X{
X    REGISTER char	 *q;
X    DIR			 *Dp;
X    DIRENTRY		 *E;
X    char		  buff[BUFSIZ];
X
X#ifdef	MSDOS
X    strlwr(p);
X#endif	/* MSDOS */
X
X    if (!GetStat(p))
X	Fprintf(stderr, "Can't walk down %s, %s.\n", p, Ermsg(errno));
X    else {
X	/* Skip leading ./ which find(1), e.g., likes to put out. */
X	if (p[0] == '.' && p[1] == '/')
X	    p += 2;
X
X	if (Wanted(p))
X	    Fprintf(Ftype(p) == F_FILE ? Ffile : Dfile, "%s\n", p);
X	else if (Verbose)
X	    Fprintf(Ftype(p) == F_FILE ? Ffile : Dfile, "PUNTED %s\n", p);
X
X	if (Ftype(p) == F_DIR)
X	    if (++level == MAX_LEVELS)
X		Fprintf(stderr, "Won't walk down %s -- more than %d levels.\n",
X			p, level);
X	    else if (Dp = opendir(p)) {
X		q = buff + strlen(strcpy(buff, p));
X		for (*q++ = '/'; E = readdir(Dp); )
X		    if (!EQ(E->d_name, ".") && !EQ(E->d_name, "..")) {
X			(void)strcpy(q, E->d_name);
X			Process(buff, level);
X		    }
X		(void)closedir(Dp);
X	    }
X	    else
X		Fprintf(stderr, "Can't open directory %s, %s.\n",
X			p, Ermsg(errno));
X    }
X}
X
X
Xmain(int ac, char **av)
X{
X    REGISTER char	*p;
X    REGISTER int	 i;
X    REGISTER int	 Oops;
X    char		 buff[BUFSIZ];
X
X    /* Parse JCL. */
X    for (Oops = 0; (i = getopt(ac, av, ".d:o:RSv")) != EOF; )
X	switch (i) {
X	default:
X	    Oops++;
X	    break;
X	case '.':
X	    DoDOTFILES++;
X	    break;
X	case 'd':
X	    switch (optarg[0]) {
X	    default:
X		Oops++;
X		break;
X	    case 'y':
X	    case 'Y':
X		Default = 'y';
X		break;
X	    case 'n':
X	    case 'N':
X		Default = 'n';
X		break;
X	    }
X	    break;
X	case 'o':
X	    if (freopen(optarg, "w", stdout) == NULL) {
X		Fprintf(stderr, "Can't open %s for output, %s.\n",
X			optarg, Ermsg(errno));
X		exit(1);
X	    }
X	case 'R':
X	case 'S':
X	    DoRCS++;
X	    break;
X	case 'v':
X	    Verbose++;
X	    break;
X	}
X    if (Oops) {
X	Fprintf(stderr, "Usage: findsrc [-d{yn}] [-.] [-{RS}] [-v] files...\n");
X	exit(1);
X    }
X    av += optind;
X
X    /* Set signal catcher, open temp files. */
X    SetSigs(TRUE, Catch);
X	strcpy(Dname,"/tmp/findDXXXXXX");
X	strcpy(Fname,"/tmp/findFXXXXXX");
X    mkstemp(Dname);
X    mkstemp(Fname);
X    Dfile = fopen(Dname, "w");
X    Ffile = fopen(Fname, "w");
X
X    /* Read list of files, determine their status. */
X    if (*av)
X	for (DEVTTY = stdin; *av; av++)
X	    Process(*av, 0);
X    else
X	while (fgets(buff, sizeof buff, stdin)) {
X	    if ((p = IDX(buff, '\n')))
X		*p = '\0';
X	    else
X		Fprintf(stderr, "Warning, line too long:\n\t%s\n", buff);
X	    Process(buff, 0);
X	}
X
X    /* First print directories. */
X    if (freopen(Dname, "r", Dfile)) {
X	while (fgets(buff, sizeof buff, Dfile))
X	    (void)fputs(buff, stdout);
X	(void)fclose(Dfile);
X    }
X
X    /* Now print regular files. */
X    if (freopen(Fname, "r", Ffile)) {
X	while (fgets(buff, sizeof buff, Ffile))
X	    (void)fputs(buff, stdout);
X	(void)fclose(Ffile);
X    }
X
X    /* That's all she wrote. */
X    (void)unlink(Dname);
X    (void)unlink(Fname);
X    exit(0);
X}
END_OF_FILE
if test 7225 -ne `wc -c <'findsrc.c'`; then
    echo shar: \"'findsrc.c'\" unpacked with wrong size!
fi
# end of 'findsrc.c'
fi
if test -f 'makekit.man' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'makekit.man'\"
else
echo shar: Extracting \"'makekit.man'\" \(4328 characters\)
sed "s/^X//" >'makekit.man' <<'END_OF_FILE'
X.TH MAKEKIT 1l
X.\" $Header: makekit.man,v 2.2 88/06/06 22:05:01 rsalz Exp $
X.SH NAME
Xmakekit \- split files up into shell archive packages
X.SH SYNOPSIS
X.B makekit
X[
X.B -1
X] [
X.B -e
X] [
X.B -x
X] [
X.BI -h\| #
X] [
X.BI -i\| name
X] [
X.BI -k\| #
X] [
X.B -m
X] [
X.BI -n\| name
X] [
X.BI -o\| name
X] [
X.B -p
X] [
X.BI -s\| #[k]
X] [
X.BI -t\| text
X] [ file... ]
X.SH DESCRIPTION
X.I Makekit
Xreads a list of files and directories, determines their sizes,
Xand parcels them up into a series of shell archives such that all the
Xarchives are of reasonable size.
XIt then invokes
X.IR shar (1l)
Xto actually create the archives.
X.PP
XBy default, no archive will be larger than about 50,000 bytes; this may be
Xchanged by using the ``\-s'' option.
XIf the number given with the ``\-s'' option ends with the letter ``k''
Xthen the size is multiplied by 1024, otherwise it is taken to be the
Xdesired maximum size, in bytes.
XEach archive will have a name that looks like
X.IR Part nn,
Xwhere ``nn'' represents the two-digit sequence number (with leading zero
Xif needed).
XThe leader part of the archive name may be changed with the ``\-n'' option.
XThe ``\-n'' is also useful when write permission to the directory being
Xarchive is denied; e.g., ``\-n/tmp/KERNEL.''
X.PP
X.I Makekit
Xreads its list of files on the command line, or standard input
Xif none are given.
XIt is also possible to specify an input filename with the ``\-i'' option.
XThe input should contain a list of files, one to a line, to separate.
XIn addition, if each input line looks like this:
X.RS
Xfilename\ \ \ whitespace\ \ \ optional-digits\ \ \ whitespace\ \ \ text
X.RE
Xthen
X.I makekit
Xwill ignore the spaces and digits, but remember the text associated with
Xeach file, and output it with the filename when generating the ``shipping
Xmanifest.''
XFurther, the ``\-h'' option may be given to have the program skip the
Xindicated number of lines in the input; this option is provided so that
X.I makekit
Xcan more easily re-parse the manifests it has generated.
X.PP
XThe generated manifest will be sent to the standard output.
XAn alternate output file may be given by using the ``\-o'' option; if
Xthe output file exists,
X.I makekit
Xwill try to rename it with an extension of
X.IR \&.BAK \&.
XIf the ``\-o'' option is used,
X.I makekit
Xwill add that name to the list of files to be archived; the ``\-e''
Xoption may be given to exclude the manifest from the list.
X.PP
XThe ``\-m'' option is the same as giving the options,
X\&``-iMANIFEST -oMANIFEST -h2.''
XThis is a common way to regenerate a set of archives after the first
Xuse of
X.I makekit
Xin a directory.
X.PP
XIf a large number of kits has to be generated, you may need to give
Xthe ``\-k'' option to increase the maximum number of kits to be
Xgenerated.
X.PP
XAfter partitioning the files and directories,
X.I makekit
Xcalls
X.I shar
Xwith the proper options to generate archives in a series.
XEach resultant archive will, when executed, check to see if all the parts
Xare present.
XIf the ``\-1'' option is used, then
X.I makekit
Xwill not instruct
X.I shar
Xto generate the checks (by not passing on the ``\-n'' and ``\-e'' options).
XBy using the ``\-t'' option, you can specify a line of starting instructions
Xto display to the recipient when all pieces have been unpacked.
XThis is useful when resending part of a series that has probably already
Xbeen unpacked by the recipient.
XSee
X.I shar
Xfor more information on multi-part archives.
XIf the ``\-x'' option is used,
X.I shar
Xis not called, but the manifest is still created.
X.PP
X.I Makekit
Xnormally reorders its input so that the archives are as ``dense'' as
Xpossible, with the exception that directories are given priority over
Xfiles, and a file named
X.I README
Xis the first of all.
XThe manifest is also sorted in alphabetical order; this makes it easy
Xto locate ``missing'' files when the distribution is a large one.
XThe ``\-p'' option may be used to override both sortings, however,
Xand preserve the original order of the input list in generating
Xboth the manifest, and the shell archives.
X.SH NOTES
X.I Makekit
Xtries to partition the files so that all directories are in the first archive.
XThis usually means the first archive must be the first one to be unpacked.
X.PP
XSaying ``the `\-k' option is to help prevent runaway packaging'' is probably
X.I "post hoc propter hoc"
Xreasoning.
X.SH "SEE ALSO"
Xfindsrc(1l), shar(1l)
END_OF_FILE
if test 4328 -ne `wc -c <'makekit.man'`; then
    echo shar: \"'makekit.man'\" unpacked with wrong size!
fi
# end of 'makekit.man'
fi
if test -f 'shar.c' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'shar.c'\"
else
echo shar: Extracting \"'shar.c'\" \(7729 characters\)
sed "s/^X//" >'shar.c' <<'END_OF_FILE'
X/*
X**  SHAR
X**  Make a shell archive of a list of files.
X*/
X#include "shar.h"
X#ifdef	RCSID
Xstatic char RCS[] =
X	"$Header: /Users/yaya/ccshar/RCS/shar.c,v 1.1 2005/08/03 02:31:07 root Exp root $";
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
X  "! /bin/sh",
X  " This is a shell archive.  Remove anything before this line, then unpack",
X  " it by saving it into a file and typing \"sh file\".  To overwrite existing",
X  " files, type \"sh file -c\".  You can also feed this as standard input via",
X  " unshar, or by typing \"sh <file\", e.g..  If this archive is complete, you",
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
X	Printf("if test ! -d '%s' ; then\n", Name);
X	Printf("    echo shar: Creating directory \\\"'%s'\\\"\n", Name);
X	Printf("    mkdir '%s'\n", Name);
X	Printf("fi\n");
X    }
X    else {
X	if (freopen(file, "r", stdin) == NULL) {
X	    Fprintf(stderr, "Can't open %s, %s\n", file, Ermsg(errno));
X	    exit(1);
X	}
X
X	/* Emit the per-file prolog. */
X	Printf("if test -f '%s' -a \"${1}\" != \"-c\" ; then \n", Name);
X	Printf("  echo shar: Will not clobber existing file \\\"'%s'\\\"\n",
X	       Name);
X	Printf("else\n");
X	Printf("echo shar: Extracting \\\"'%s'\\\" \\(%ld character%s\\)\n",
X	       Name, (long)Size, Size == 1 ? "" : "s");
X	Printf("sed \"s/^X//\" >'%s' <<'END_OF_FILE'\n", Name, Name);
X
X	/* Output the file contents. */
X	for (Bads = 0; fgets(buf, BUFSIZ, stdin); )
X	    if (buf[0]) {
X#ifdef	TOO_FANCY
X		if (buf[0] == 'X' || buf[0] == 'E' || buf[0] == 'F'
X		 || !isascii(buf[0]) || !isalpha(buf[0]))
X		    /* Protect non-alpha's, the shar pattern character, the
X		     * END_OF_FILE message, and mail "From" lines. */
X		    (void)putchar('X');
X#else
X		/* Always put out a leading X. */
X		(void)putchar('X');
X#endif	/* TOO_FANCY */
X		for (s = buf; *s; s++) {
X		    if (BADCHAR(*s))
X			Bads++;
X		    (void)putchar(*s);
X		}
X	    }
X
X	/* Tell about and control characters. */
X	Printf("END_OF_FILE\n", Name);
X	if (Bads) {
X	    Printf(
X    "echo shar: %d control character%s may be missing from \\\"'%s'\\\"\n",
X		   Bads, Bads == 1 ? "" : "s", Name);
X	    Fprintf(stderr, "Found %d control char%s in \"'%s'\"\n",
X		    Bads, Bads == 1 ? "" : "s", Name);
X	}
X
X	/* Output size check. */
X	Printf("if test %ld -ne `wc -c <'%s'`; then\n", (long)Size, Name);
X	Printf("    echo shar: \\\"'%s'\\\" unpacked with wrong size!\n", Name);
X	Printf("fi\n");
X
X	/* Executable? */
X	if (Fexecute(file))
X	    Printf("chmod +x '%s'\n", Name);
X
X	Printf("# end of '%s'\nfi\n", Name);
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
X		"USAGE: shar [-b] [-o:] [-i:] [-n:e:t:] file... >SHAR\n");
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
X        Printf("#\t\t\"End of shell archive.\"\n");
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
X    Printf("PATH=/bin:/usr/bin:/usr/ucb ; export PATH\n");
X
X    /* Do it. */
X    while (*Flist)
X	shar(*Flist++, Basename);
X
X    /* Epilog. */
X    if (Knum && Kmax) {
X	Printf("echo shar: End of archive %d \\(of %d\\).\n", Knum, Kmax);
X	Printf("cp /dev/null ark%disdone\n", Knum);
X	Printf("MISSING=\"\"\n");
X	Printf("for I in");
X	for (i = 0; i < Kmax; i++)
X	    Printf(" %d", i + 1);
X	Printf(" ; do\n");
X	Printf("    if test ! -f ark${I}isdone ; then\n");
X	Printf("\tMISSING=\"${MISSING} ${I}\"\n");
X	Printf("    fi\n");
X	Printf("done\n");
X	Printf("if test \"${MISSING}\" = \"\" ; then\n");
X	if (Kmax == 1)
X	    Printf("    echo You have the archive.\n");
X	else if (Kmax == 2)
X	    Printf("    echo You have unpacked both archives.\n");
X	else
X	    Printf("    echo You have unpacked all %d archives.\n", Kmax);
X	if (Trailer && *Trailer)
X	    Printf("    echo \"%s\"\n", Trailer);
X	Printf("    rm -f ark[1-9]isdone%s\n",
X	       Kmax >= 9 ? " ark[1-9][0-9]isdone" : "");
X	Printf("else\n");
X	Printf("    echo You still need to unpack the following archives:\n");
X	Printf("    echo \"        \" ${MISSING}\n");
X	Printf("fi\n");
X	Printf("##  End of shell archive.\n");
X    }
X    else {
X        Printf("echo shar: End of shell archive.\n");
X	if (Trailer && *Trailer)
X	    Printf("echo \"%s\"\n", Trailer);
X    }
X
X    Printf("exit 0\n");
X
X    exit(0);
X}
END_OF_FILE
if test 7729 -ne `wc -c <'shar.c'`; then
    echo shar: \"'shar.c'\" unpacked with wrong size!
fi
# end of 'shar.c'
fi
if test -f 'unshar.c' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'unshar.c'\"
else
echo shar: Extracting \"'unshar.c'\" \(8556 characters\)
sed "s/^X//" >'unshar.c' <<'END_OF_FILE'
X/*
X**  UNSHAR
X**  Unpack shell archives that might have gone through mail, notes, news, etc.
X**  This is Michael Mauldin's code which I have usurped and heavily modified.
X*/
X#include "shar.h"
X#ifdef	RCSID
Xstatic char RCS[] =
X	"$Header: /Users/yaya/ccshar/RCS/unshar.c,v 1.1 2005/08/03 02:31:07 root Exp root $";
X#endif	/* RCSID */
X
X
X/*
X**  Print error message and die.
X*/
Xstatic void
XQuit(text)
X    char	*text;
X{
X    int		 e;
X
X    e = errno;
X    Fprintf(stderr, "unshar:  %s", text);
X    if (e)
X	Fprintf(stderr, ", %s", Ermsg(e));
X    Fprintf(stderr, ".\n");
X    exit(1);
X}
X
X
X/*
X**  Does this look like a mail header line?
X*/
Xstatic int
XIsHeader(p)
X    REGISTER char	*p;
X{
X    REGISTER int	 i;
X
X    if (*p == '\0' || *p == '\n')
X	return(FALSE);
X    if (WHITE(*p))
X	return(TRUE);
X    for (i = 0; (isascii(*p) && isalnum(*p)) || HDRCHAR(*p); i++)
X	p++;
X    return(i && *p == ':');
X}
X
X
X/*
X**  Is this a /bin/sh comment line?  We check that because some shars
X**  output comments before the CUT line.
X*/
Xstatic int
XIsSHcomment(p)
X    REGISTER char	*p;
X{
X    while (isascii(*p) &&
X      (isalpha(*p) || WHITE(*p) || *p == '\n' || *p == ',' || *p == '.'))
X	p++;
X    return(*p == '\0');
X}
X
X
X/*
X**  Return TRUE if p has wd1 and wd2 as words (i.e., no preceeding or
X**  following letters).  Clever code, Michael.
X*/
Xstatic int
XHas(p, wd1, wd2)
X    REGISTER char	*p;
X    REGISTER char	*wd1;
X    REGISTER char	*wd2;
X{
X    REGISTER char	*wd;
X    REGISTER int	 first;
X
X    wd = wd1;
X    first = TRUE;
Xagain: 
X    while (*p) {
X	if (!isascii(*p) || !isalpha(*p)) {
X	    p++;
X	    continue;
X	}
X	while (*p++ == *wd++) {
X	    if (*wd == '\0') {
X		if (!isascii(*p) || !isalpha(*p)) {
X		    if (!first)
X			return(TRUE);
X		    first = FALSE;
X		    wd = wd2;
X		    goto again;
X		}
X		break;
X	    }
X	}
X	while (isascii(*p) && isalpha(*p))
X	    p++;
X	wd = first ? wd1 : wd2;
X    }
X    return(FALSE);
X}
X
X
X/*
X**  Here's where the work gets done.  Skip headers and try to intuit
X**  if the file is, e.g., C code, etc.
X*/
Xstatic int
XFound(Name, buff, Forced, Stream, Header)
X    REGISTER char	*Name;
X    REGISTER char	*buff;
X    REGISTER int	 Forced;
X    REGISTER FILE	*Stream;
X    REGISTER FILE	*Header;
X{
X    REGISTER char	*p;
X    REGISTER int	 InHeader;
X    char		 lower[BUFSIZ];
X
X    if (Header)
X	InHeader = TRUE;
X
X    while (TRUE) {
X	/* Read next line, fail if no more */
X	if (fgets(buff, BUFSIZ, Stream) == NULL) {
X	    Fprintf(stderr, "unshar:  No shell commands in %s.\n", Name);
X	    return(FALSE);
X	}
X
X	/* See if it looks like another language. */
X	if (!Forced) {
X	    if (PREFIX(buff, "#include") || PREFIX(buff, "# include")
X	     || PREFIX(buff, "#define") || PREFIX(buff, "# define")
X	     || PREFIX(buff, "#ifdef") || PREFIX(buff, "# ifdef")
X	     || PREFIX(buff, "#ifndef") || PREFIX(buff, "# ifndef")
X	     || (PREFIX(buff, "/*")
X	      && !PREFIX(buff, NOTES1) && !PREFIX(buff, NOTES2)))
X		p = "C code";
X	    else if (PREFIX(buff, "(*"))		/* For vi :-) */
X		p = "PASCAL code";
X	    else if (buff[0] == '.'
X		  && isascii(buff[1]) && isalpha(buff[1])
X		  && isascii(buff[2]) && isalpha(buff[2])
X		  && isascii(buff[3]) && !isalpha(buff[3]))
X		p = "TROFF source";
X	    else
X		p = NULL;
X	    if (p) {
X		Fprintf(stderr,
X			"unshar:  %s is apparently %s, not a shell archive.\n",
X			Name, p);
X		return(FALSE);
X	    }
X	}
X
X	/* Does this line start with a shell command or comment? */
X	if ((buff[0] == '#' && !IsSHcomment(buff + 1))
X	 || buff[0] == ':' || PREFIX(buff, "echo ")
X	 || PREFIX(buff, "sed ") || PREFIX(buff, "cat ")) {
X	    return(TRUE);
X	}
X
X	/* Does this line say "Cut here"? */
X	for (p = strcpy(lower, buff); *p; p++)
X	    if (isascii(*p) && islower(*p))
X		*p = toupper(*p);
X	if (PREFIX(buff, "-----") || Has(lower, "cut", "here")
X	 || Has(lower, "cut", "cut") || Has(lower, "tear", "here")) {
X	    /* Get next non-blank line. */
X	    do {
X		if (fgets(buff, BUFSIZ, Stream) == NULL) {
X		    Fprintf(stderr, "unshar:  cut line is last line of %s\n",
X			    Name);
X		    return(FALSE);
X		}
X	    } while (*buff == '\n');
X
X	    /* If it starts with a comment or lower-case letter we win. */
X	    if (*buff == '#' || *buff == ':'
X	     || (isascii(*buff) && islower(*buff)))
X		return(TRUE);
X
X	    /* The cut message lied. */
X	    Fprintf(stderr, "unshar: %s is not a shell archive,\n", Name);
X	    Fprintf(stderr, "        the 'cut' line was followed by: %s", buff);
X	    return(FALSE);
X	}
X
X	if (Header) {
X	    (void)fputs(buff, Header);
X	    if (InHeader && !IsHeader(buff))
X		InHeader = FALSE;
X	}
X    }
X}
X
X
X/*
X**  Create file for the header, find true start of the archive,
X**  and send it off to the shell.
X*/
Xstatic void
XUnshar(Name, HdrFile, Stream, Saveit, Forced)
X    char		*Name;
X    char		*HdrFile;
X    REGISTER FILE 	*Stream;
X    int			 Saveit;
X    int			 Forced;
X{
X    REGISTER FILE	*Header;
X#ifndef	USE_MY_SHELL
X    REGISTER FILE	*Pipe;
X#endif	/* USE_MY_SHELL */
X    char		*p;
X    char		 buff[BUFSIZ];
X
X    if (Saveit) {
X	/* Create a name for the saved header. */
X	if (HdrFile)
X	    (void)strcpy(buff, HdrFile);
X	else if (Name) {
X	    p = RDX(Name, '/');
X	    (void)strncpy(buff, p ? p + 1 : Name, 14);
X	    buff[10] = 0;
X	    (void)strcat(buff, ".hdr");
X	}
X	else
X	    (void)strcpy(buff, "UNSHAR.HDR");
X
X	/* Tell user, and open the file. */
X	Fprintf(stderr, "unshar:  Sending header to %s.\n", buff);
X	if ((Header = fopen(buff, "a")) == NULL)
X	    Quit("Can't open file for header");
X    }
X    else
X	Header = NULL;
X
X    /* If name is NULL, we're being piped into... */
X    p = Name ? Name : "the standard input";
X    Printf("unshar:  Doing %s:\n", p);
X
X    if (Found(p, buff, Forced, Stream, Header)) {
X#ifdef	USE_MY_SHELL
X	BinSh(Name, Stream, buff);
X#else
X	if ((Pipe = popen("/bin/sh", "w")) == NULL)
X	    Quit("Can't open pipe to /bin/sh process");
X
X	(void)fputs(buff, Pipe);
X	while (fgets(buff, sizeof buff, Stream))
X	    (void)fputs(buff, Pipe);
X
X	(void)pclose(Pipe);
X#endif	/* USE_MY_SHELL */
X    }
X
X    /* Close the headers. */
X    if (Saveit)
X	(void)fclose(Header);
X}
X
X
Xmain(ac, av)
X    REGISTER int	 ac;
X    REGISTER char	*av[];
X{
X    REGISTER FILE	*Stream;
X    REGISTER int	 i;
X    char		*p;
X    char		*HdrFile;
X    char		 cwd[BUFSIZ];
X    char		 dir[BUFSIZ];
X    char		 buff[BUFSIZ];
X    int			 Saveit;
X    int			 Forced;
X
X    /* Parse JCL. */
X    p = getenv("UNSHARDIR");
X    Saveit = DEF_SAVEIT;
X    HdrFile = NULL;
X    for (Forced = 0; (i = getopt(ac, av, "c:d:fh:ns")) != EOF; )
X	switch (i) {
X	default:
X	    Quit("Usage: unshar [-fs] [-c dir] [-h hdrfile] [input files]");
X	    /* NOTREACHED */
X	case 'c': 
X	case 'd': 
X	    p = optarg;
X	    break;
X	case 'f':
X	    Forced++;
X	    break;
X	case 'h':
X	    HdrFile = optarg;
X	    /* FALLTHROUGH */
X	case 's': 
X	    Saveit = TRUE;
X	    break;
X	case 'n':
X	    Saveit = FALSE;
X	    break;
X	}
X    av += optind;
X
X    /* Going somewhere? */
X    if (p) {
X	if (*p == '?') {
X	    /* Ask for name; go to THE_TTY if we're being piped into. */
X	    Stream = isatty(fileno(stdin)) ? stdin : fopen(THE_TTY, "r");
X	    if (Stream == NULL)
X		Quit("Can't open tty to ask for directory");
X	    Printf("unshar:  what directory?  ");
X	    (void)fflush(stdout);
X	    if (fgets(buff, sizeof buff, Stream) == NULL
X	     || buff[0] == '\n'
X	     || (p = IDX(buff, '\n')) == NULL)
X		Quit("Okay, cancelled");
X	    *p = '\0';
X	    p = buff;
X	    if (Stream != stdin)
X		(void)fclose(Stream);
X	}
X
X	/* If name is ~/blah, he means $HOME/blah. */
X	if (*p == '~') {
X	    if (getenv("HOME") == NULL)
X		Quit("You have no $HOME?");
X	    (void)sprintf(dir, "%s/%s", getenv("HOME"), p + 1);
X	    p = dir;
X	}
X
X	/* If we're gonna move, first remember where we were. */
X	if (Cwd(cwd, sizeof cwd) == NULL) {
X	    Fprintf(stderr, "unshar warning:  Can't get current directory.\n");
X	    cwd[0] = '\0';
X	}
X
X	/* Got directory; try to go there.  Only make last component. */
X	if (chdir(p) < 0 && (mkdir(p, 0777) < 0 || chdir(p) < 0))
X	    Quit("Cannot chdir nor mkdir desired directory");
X    }
X    else
X	cwd[0] = '\0';
X
X    /* No buffering. */
X    (void)setbuf(stdout, (char *)NULL);
X    (void)setbuf(stderr, (char *)NULL);
X
X    if (*av)
X	/* Process filenames from command line. */
X	for (; *av; av++) {
X	    if (cwd[0] && av[0][0] != '/') {
X		(void)sprintf(buff, "%s/%s", cwd, *av);
X		*av = buff;
X	    }
X	    if ((Stream = fopen(*av, "r")) == NULL)
X		Fprintf(stderr, "unshar:  Can't open file '%s'.\n", *av);
X	    else {
X		Unshar(*av, HdrFile, Stream, Saveit, Forced);
X		(void)fclose(Stream);
X	    }
X	}
X    else
X	/* Do standard input. */
X	Unshar((char *)NULL, HdrFile, stdin, Saveit, Forced);
X
X    /* That's all she wrote. */
X    exit(0);
X}
END_OF_FILE
if test 8556 -ne `wc -c <'unshar.c'`; then
    echo shar: \"'unshar.c'\" unpacked with wrong size!
fi
# end of 'unshar.c'
fi
echo shar: End of archive 2 \(of 3\).
cp /dev/null ark2isdone
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
