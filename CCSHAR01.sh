#! /bin/sh
# This is a shell archive.  Remove anything before this line, then unpack
# it by saving it into a file and typing "sh file".  To overwrite existing
# files, type "sh file -c".  You can also feed this as standard input via
# unshar, or by typing "sh <file", e.g..  If this archive is complete, you
# will see the following message at the end:
#		"End of archive 1 (of 3)."
# Contents:  MANIFEST Makefile README config.h config.sVr3 cshar.man
#   findsrc.man glue.c lcwd.c lexec.c lfiles.c lhost.c llib.c lmem.c
#   luser.c patchlevel.h shar.h shar.man shell.c shell.man unshar.man
# Wrapped by yaya@server.chm.bnl.gov on Sun Sep  3 19:20:13 1995
PATH=/bin:/usr/bin:/usr/ucb ; export PATH
if test -f 'MANIFEST' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'MANIFEST'\"
else
echo shar: Extracting \"'MANIFEST'\" \(1981 characters\)
sed "s/^X//" >'MANIFEST' <<'END_OF_FILE'
X   File Name		Archive #	Description
X-----------------------------------------------------------
X MANIFEST                   1	This shipping list
X Makefile                   1	Control file for Unix make program
X README                     1	Acknowledgements, installation notes
X config.h                   1	Default configuration file
X config.sVr3                1	Configuration for SystemV Releases 3.1 and 3.2
X config.x386                2	configuration for Xenix on a 386
X cshar.c                    3	Create csh script to create files
X cshar.man                  1	Manual page for cshar
X dir.amiga                  2	A partial Amiga readdir package
X dir.msdos                  2	An MS-DOS readdir package
X findsrc.c                  2	Find source files, based on filename
X findsrc.man                1	Manual page for findsrc
X glue.c                     1	Glue that so unshar uses my /bin/sh parser
X lcwd.c                     1	Routines to find current directory
X lexec.c                    1	Fork, exec, system, signal, etc., routines
X lfiles.c                   1	File size and type routines
X lhost.c                    1	Find our machine name
X llib.c                     1	Stuff that should be in your C library
X lmem.c                     1	Memory allocator, uses calloc
X luser.c                    1	Get user's name
X makekit.c                  3	Partition files into reasonable-sized kits
X makekit.man                2	Manual page for makekit
X parser.c                   3	Interpreter for shell archives
X patchlevel.h               1	Mistake recorder
X shar.c                     2	Create script to create files
X shar.h                     1	Header file, used by everyone
X shar.man                   1	Manual page for makekit
X shell.c                    1	Main routine for my shell interpreter
X shell.man                  1	Manual page for shell
X unshar.c                   2	Strip news, notes, mail headers from shar's
X unshar.man                 1	Manual page for unshar
END_OF_FILE
if test 1981 -ne `wc -c <'MANIFEST'`; then
    echo shar: \"'MANIFEST'\" unpacked with wrong size!
fi
# end of 'MANIFEST'
fi
if test -f 'Makefile' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'Makefile'\"
else
echo shar: Extracting \"'Makefile'\" \(3604 characters\)
sed "s/^X//" >'Makefile' <<'END_OF_FILE'
X##
X##  SOURCE-SHIPPING TOOLS MAKEFILE
X##  $Header: /user_data/systems/yaya/cif/shar/xcshar/Makefile,v 1.1 1995/09/03 02:34:27 yaya Exp yaya $
X##
X
X## Grrrr...
XSHELL	= /bin/sh
XCC = cc
X
X##  Edit appropriately, such as -g if you don't trust me...
X#  Flags to build for AIX with cshar version making minimal use of "X"
XCFLAGS	= -O -D_NO_PROTO -DJUST_TEXT
X#  Flags to build for non-AIX systems
X#CFLAGS  = -O -DJUST_TEXT
X
X##  Where the readdir() and friends are, if not in your C library.
X#DIRLIB	= -lndir
X
X##  Use these two lines if you use ranlib...
XAR_OBJ	= $(LIB_OBJ)
XRANLIB	= ranlib lib.a
X##  ...or use these two if you need tsort instead...
X#AR_OBJ	= `lorder $(LIB_OBJ) | tsort`
X#RANLIB	= @echo
X##  ...or these two if you need neither.
X#AR_OBJ	= $(LIB_OBJ)
X#RANLIB	= @echo
X
X##  Where executables should be put.
XDESTDIR	= /usr/local/bin
X
X##  The "foo" manpage will get put in $(MANDIR)/foo.$1
XMANDIR	= /usr/local/man/man1
X1	= 1
X#MANDIR	= /usr/man/u_man/manl
X#1	= 1L
X#MANDIR	= /usr/man/local
X#1	= 1
X#MANDIR	= /usr/man/man.M
X#1	= M
X
X##
X##  END OF CONFIGURATION SECTION
X##
X
X##  Header files.
XHDRS	= shar.h config.h
XLIB	= lib.a
X
X##  Programs and documentation.
XPROGRAMS= findsrc    makekit    shar    unshar    shell    cshar
XMANPAGES= findsrc.$1 makekit.$1 shar.$1 unshar.$1 shell.$1 cshar.$1
X
X##  Our library of utility functions.
XLIB_SRC	= glue.c parser.c lcwd.c lexec.c lfiles.c lhost.c llib.c lmem.c luser.c
XLIB_OBJ	= glue.o parser.o lcwd.o lexec.o lfiles.o lhost.o llib.o lmem.o luser.o
X
X
Xall:		$(PROGRAMS) $(MANPAGES)
X	touch all
X
X##  You might want to change these actions...
Xinstall:	all
X	cd $(DESTDIR) ; rm -f $(PROGRAMS)
X	cp $(PROGRAMS) $(DESTDIR)
X	cd $(DESTDIR) ; strip $(PROGRAMS) ; chmod 755 $(PROGRAMS)
X#	cd $(DESTDIR) ; /etc/chown root $(PROGRAMS)
X	cd $(MANDIR) ; rm -f $(MANPAGES)
X	cp $(MANPAGES) $(MANDIR)
X	touch install
X
Xclean:
X	rm -f *.[oa] *.$1 *.BAK $(PROGRAMS) unshar.safe
X	rm -f lint lib.ln tags core foo a.out Part?? all install
X
X
X##  Creating manpages.
X.SUFFIXES:	.$1 .man
X.man.$1:
X	@rm -f $@
X	cp $< $@
X	chmod 444 $@
X
X
X##  Programs.
Xfindsrc:	findsrc.o $(HDRS) $(LIB)
X	@rm -f $@
X	$(CC) $(CFLAGS) -o findsrc findsrc.o $(LIB) $(DIRLIB)
X
Xmakekit:	makekit.o $(HDRS) $(LIB)
X	@rm -f $@
X	$(CC) $(CFLAGS) -o makekit makekit.o $(LIB) $(DIRLIB)
X
Xshar:		shar.o $(HDRS) $(LIB)
X	@rm -f $@
X	$(CC) $(CFLAGS) -o shar shar.o $(LIB) $(DIRLIB)
Xcshar:		cshar.o $(HDRS) $(LIB)
X	@rm -f $@
X	$(CC) $(CFLAGS) -o cshar cshar.o $(LIB) $(DIRLIB)
X
X
Xshell:		shell.o $(HDRS) $(LIB)
X	@rm -f $@
X	$(CC) $(CFLAGS) -o shell shell.o $(LIB) $(DIRLIB)
X
Xunshar:		unshar.o $(HDRS) $(LIB)
X	@rm -f $@
X	$(CC) $(CFLAGS) -o unshar unshar.o $(LIB) $(DIRLIB)
X
X
X##  Special case, a version of unshar that uses the /bin/sh interpreter.
Xunshar.safe:	unshar.c $(HDRS) $(LIB)
X	@rm -f $@
X	@rm -f unshar.o
X	$(CC) $(CFLAGS) -DUSE_MY_SHELL -o unshar unshar.c $(LIB) $(DIRLIB)
X	@rm -f unshar.o
X
X
X##  Support your local library.
Xlib.a:		$(LIB_OBJ)
X	@rm -f $@
X	ar r lib.a $(AR_OBJ)
X	$(RANLIB)
X$(LIB_OBJ):	$(HDRS)
X
X
X##  Lint; this is probably only good for BSD-derived lints.
X##  Ultrix 1.2 lint really hates the !var construct, for some reason.
X#LINTF	= -p -ahb
XLINTF	= -ahb
X##  A slight speed hack...
XX	= exec
Xlint:		$(PROGRAMS) lib.ln
X	@rm -f $@
X	$X lint $(LINTF) -u  >lint $(LIB_SRC)
X	$X lint $(LINTF)    >>lint findsrc.c lib.ln
X	$X lint $(LINTF)    >>lint makekit.c lib.ln
X	$X lint $(LINTF)    >>lint shar.c    lib.ln
X	$X lint $(LINTF)    >>lint shell.c   lib.ln
X	$X lint $(LINTF)    >>lint unshar.c  lib.ln
X#	$X lint $(LINTF) -DUSE_MY_SHELL >>lint unshar.c  lib.ln
X
Xlib.ln:		$(LIB_SRC)
X	@rm -f $@
X	lint -CX $(LIB_SRC)
X	mv llib-lX.ln lib.ln
END_OF_FILE
if test 3604 -ne `wc -c <'Makefile'`; then
    echo shar: \"'Makefile'\" unpacked with wrong size!
fi
# end of 'Makefile'
fi
if test -f 'README' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'README'\"
else
echo shar: Extracting \"'README'\" \(4480 characters\)
sed "s/^X//" >'README' <<'END_OF_FILE'
XREADME for cshar - C-shell Archive Package
X
XThis package is a slight modification to the Rich Salz shar package
Xof 1988.  What has been added to the package is one new program,
Xcshar (as cshar.c with manual page cshar.1) a new option for makekit
X(-c to use cshar instead of shar) and the related changes to Makefile.
Xcshar is intended to provide archives to be expanded by the C-shell,
Xcsh, rather than the default shell, sh, and to provide the capability
Xof producing archive which are simply to unpack by hand with an
Xeditor.  If your audience is strictly unix machines and machines which
Xcan run programs which unpack shar files, you don't need this package,
Xstick to shar.  The basis for this version is the shar release with
Xpatches through patch3.
X
XPortions of this work were done at Brookhaven National Laboratory with
Xthe support of the U.S. Department of Energy.
X
X2 September 1995
X
X    -- Herbert J. Bernstein, yaya@aip.org
X       Bernstein+Sons, P.O. Box 177, Bellport, NY 11713-0177
X
XREADME for shar - Shell Archive Package by Rich Salz
X 
XThis set of tools is designed to make it easier to ship sources around.  I
Xwrote them because I do a lot of that as moderator of comp.sources.unix,
Xand nothing else did the job for me.  This set isn't perfect, but's very
Xclose.  Included are a program to find source files, a program to
Xpartition them into reasonable sizes, a program to make shell archives out
Xof them, a program to strip mail, news, and notes headers from archives
Xbefore feeding them to a shell, and a program that simulates enough
X/bin/sh syntax so that non-Unix systems can unpack them.
X
XThe sources in this distribution are being released into the public
Xdomain; do what you want, but let your conscience be your guide.  If you
Xsomehow enhance this package, please send it on to me so that others can
Xbenefit.
X
XI'll try to answer any questions or problems that come up -- send me
Xelectronic mail.
X
XTo install, edit the Makefile and config.h as necessary then run make;
Xdoing make install will put the manpages and executables where you told
Xit to.  I don't think "make lint" will be totally reasonable except on
Xa BSD-derived system, but you can try.  If you write config.h files for
Xother systems, send them to me.
X
XIf you aren't running on Unix, then you will have to write replacements
Xfor the functions in the lxxxx.c files; everything else should be OK.  If
Xyou find something in another file that you had to change, please let me
Xknow.  If you don't have a Unix-like make available, you will have to
Xwrite a command script or otherwise work out something with your compiler,
Xlinker, etc.
X
XI believe this works under MSDOS.  If you have diffs, send them to me.
XOwen at Oxford Trading Partners, oxtrap!osm, ported an earlier version to
XMSDOS; I hope I didn't break anything when I merged his changes into what
XI've got now.  Same for Amiga and other PC's.  I might do a VMS port.  The
Xdir.msdos shar (which I haven't touched) seems to be solid; I don't know
Xabout the dir.amiga code.
X
XI freely stole ideas from a number of people who have been good enough to
Xput their stuff out on Usenet.  Particular thanks to Gary Perlman and
XLarry Wall for giving me something nice to reverse-engineer, and Michael
XMauldin for unshar.  People who sent significant comments and fixes from
Xearlier versions include Bob Desinger, Darryl Ohahato, Jamie Watson, Joel
XShprentz, Ken Yap, Matt Landau, Paul Vixie, Shane McCarron, Tim Pointing,
XTom Beattie, Vital Dobroey, and Don Libes.  Thanks to all of them,
Xparticularly Paul for an amazing number of comments on earlier versions.
X
XOn a philosophical note, I've tried to make this all as general as
Xpossible for shipping sources around.  I'm not interested in binaries, so
Xthings like automatically running uuencode don't interest me a great
Xdeal.  I haven't come up with a good portable way to split files into
Xpieces if they're too large, and doubt I ever will.  There are too many
Xinstallation parameters, but I'm not particularly worried about that:  Once
Xyou get things working, consider it incentive to avoid future changes.
XIt would be nice if I could use Larry's meta-Config, but that only works
Xon Unix (and Eunice).  Send me your config.h file so that others can benefit.
X
XEnjoy!
X	Rich $alz
X	BBN Laboratories, Inc.
X	10 Moulton Street
X	Cambridge, MA  02238
X	rsalz@bbn.com
X	rsalz@uunet.uu.net
X
XMy, my, my, aren't we anal:
X  $Header: /user_data/systems/yaya/xcshar/README,v 1.1 1995/09/03 02:17:27 yaya Exp yaya $
END_OF_FILE
if test 4480 -ne `wc -c <'README'`; then
    echo shar: \"'README'\" unpacked with wrong size!
fi
# end of 'README'
fi
if test -f 'config.h' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'config.h'\"
else
echo shar: Extracting \"'config.h'\" \(4258 characters\)
sed "s/^X//" >'config.h' <<'END_OF_FILE'
X/*
X**  Configuration file for shar and friends.
X**
X**  This is known to work on Ultrix1.2 and Sun3.4 machines; it may work
X**  on other BSD variants, too.
X**
X**  $Header: config.h,v 2.2 88/06/06 22:05:27 rsalz Exp $
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
X#define USE_SYSERRLIST			/* Have sys_errlist[], sys_nerr? */
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
X
X
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
if test 4258 -ne `wc -c <'config.h'`; then
    echo shar: \"'config.h'\" unpacked with wrong size!
fi
# end of 'config.h'
fi
if test -f 'config.sVr3' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'config.sVr3'\"
else
echo shar: Extracting \"'config.sVr3'\" \(4201 characters\)
sed "s/^X//" >'config.sVr3' <<'END_OF_FILE'
X/*
X**  Configuration file for shar and friends.
X**
X**  This is for System V release 3.1 and 3.2.
X**
X**  $Header: config.sVr3,v 2.1 88/06/06 22:05:40 rsalz Exp $
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
X#define IDX		strchr		/* Maybe strchr?		*/
X#define RDX		strrchr		/* Maybe strrchr?		*/
X/*efine NEED_MKDIR			/* Don't have mkdir(2)?		*/
X/*efine NEED_QSORT			/* Don't have qsort(3)?		*/
X#define NEED_RENAME			/* Don't have rename(2 or 3)?	*/
X/*efine NEED_GETOPT			/* Need local getopt object?	*/
X#define CAN_POPEN			/* Can invoke file(1) command?	*/
X/*efine USE_MY_SHELL			/* Don't popen("/bin/sh")?	*/
X/*efine BACKUP_PREFIX	"B-"		/* Instead of ".BAK" suffix?	*/
Xtypedef void		 sigret_t;	/* What a signal handler returns */
Xtypedef int		*align_t;	/* Worst-case alignment, for lint */
Xtypedef long		time_t;		/* Needed for non-BSD sites?	*/
Xtypedef long		off_t;		/* Needed for non-BSD sites?	*/
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
X
X
X/*
X**  There are several ways to get current machine name.  Enable just one
X**  of one of the following lines.
X*/
X/*efine GETHOSTNAME			/* Use gethostname(2) call	*/
X#define UNAME				/* Use uname(2) call		*/
X/*efine UUNAME				/* Invoke "uuname -l"		*/
X/*efine	WHOAMI				/* Try /etc/whoami & <whoami.h>	*/
X/*efine HOST		"SITE"		/* If all else fails		*/
X
X
X/*
X**  There are several different ways to get the current working directory.
X**  Enable just one of the following lines.
X*/
X/*efine GETWD				/* Use getwd(3) routine		*/
X#define GETCWD				/* Use getcwd(3) routine	*/
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
if test 4201 -ne `wc -c <'config.sVr3'`; then
    echo shar: \"'config.sVr3'\" unpacked with wrong size!
fi
# end of 'config.sVr3'
fi
if test -f 'cshar.man' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'cshar.man'\"
else
echo shar: Extracting \"'cshar.man'\" \(3321 characters\)
sed "s/^X//" >'cshar.man' <<'END_OF_FILE'
X.TH CSHAR 1l
X.\" $Header
X.SH NAME
Xcshar \- create C-shell archive file for extraction by /bin/csh$
X.SH SYNOPSIS
X.B cshar
X[
X.B \-b
X] [
X.BI \-i\| input_file
X] [
X.BI \-n\| seq_number
X] [
X.BI \-e\| seq_end
X] [
X.BI \-o\| output_file
X] [
X.BI \-t\| final_text
X] [file...]
X.SH DESCRIPTION
X.I cshar
Xtakes a list of files, and generates a
X.IR /bin/csh
Xscript that, when executed, will re-create those files in a different
Xdirectory or on a different machine.
X.PP
X.I cshar
Xdiffers from
X.IR shar(1)
Xin using the C-shell
X.IR csh(1)
Xinstead of the default shell
X.IR sh(1).
XWhen built with the flag JUST_TEXT,
X.I cshar
Xcreates archives which are easier for manual extraction of files
Xon non-unix systems than are the archives built by
X.IR shar(1).
XIf this is not a consideration, the original program,
X.IR shar(1),
Xis preferred.
X.PP
XThe resultant script will use
X.IR wc (1)
Xto do a mild error-check, and will warn about possibly-omitted
Xcontrol characters.
X.PP
X.I cshar
Xgenerates scripts that will make directories and plain files.
XIt will not try to generate intermediate filenames, however, so
X.RS
Xcshar foo/bar/file
X.RE
Xwill not work.  Do
X.RS
Xcshar foo foo/bar foo/bar/file
X.RE
Xinstead.
X.PP
XThe script is normally sent to standard output; the ``\-o'' option may be
Xused to specify an output filename.
XThis is designed to prevent filling up the disk if
X.RS
Xcshar * >CSHAR
X.RE
Xcommand is done; do
X.RS
Xcshar -o CSHAR *
X.RE
Xinstead.
X.PP
XThe list of files is normally specified on the command line; the ''\-i''
Xoption may be used instead, to specify a file that contains the list
Xof files to pack up, one per line.
XIf the file name is ``-'' the standard input is read.
X.PP
XThe ``\-b'' option says that all leading directory names should be stripped
Xfrom the file when they are packed into the archive.
XFor example,
X.RS
Xcshar -b /etc/termcap
X.RE
Xcreates an archive that, when executed, creates a file named
X``termcap'' in the current directory, rather than overwrite the
Xhost system file.
XNote, however, that the scripts generated by
X.I cshar
Xnormally refuse to overwrite pre-existing files.
X.SS "Multi\-part Archives"
XMost larger software packages are usually sent out in two or more shell
Xarchives.
XThe ``\-n,'' ``\-e,'' and ``\-t'' options are used to make an archive
Xthat is part of a series.
XThe individual archives are often called ``kits'' when this is done.
XThe ``\-n'' option specifies the archive number; the ``\-e'' option species
Xthe highest number in the series.
XWhen executed, the generated archives will then echo messages like
X.RS
Xcshar: End of archive 3 of 9.
X.RE
Xat their end.
X.PP
XIn addition, each cshar will generate a file named
X.IR ark X isdone .
XEach script will contain a loop to check for the presence of these
Xfiles, and indicate to the recipient which archives still need to be
Xexecuted.
XThe ``\-t'' option may be used to give starting instructions to the recipient.
XWhen the scripts determine that all the archives have been unpacked,
Xthe text specified with this flag is displayed.
XFor example,
X.RS
Xcshar -n1 -k9 -t "Now do 'sh ./Configure'" *.c >CSHAR
X.RE
XAdds commands to output the following when all the archives have been unpacked:
X.RS
X.nf
XYou have run all 9 archives.
XNow do 'sh ./Configure'
X.fi
X.RE
X.SH "SEE ALSO"
Xecho(1), findsrc(1l), makekit(1l), mkdir(1), sh(1), shar(1), test(1), unshar(1l),
Xwc(1).
END_OF_FILE
if test 3321 -ne `wc -c <'cshar.man'`; then
    echo shar: \"'cshar.man'\" unpacked with wrong size!
fi
# end of 'cshar.man'
fi
if test -f 'findsrc.man' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'findsrc.man'\"
else
echo shar: Extracting \"'findsrc.man'\" \(1859 characters\)
sed "s/^X//" >'findsrc.man' <<'END_OF_FILE'
X.TH FINDSRC 1l
X.\" $Header: findsrc.man,v 2.0 88/05/27 13:28:20 rsalz Exp $
X.SH NAME
Xfindsrc \- walk directories, trying to find source files
X.SH SYNOPSIS
X.B findsrc
X[
X.B \-.
X] [
X.BI \-d\| y_or_n
X] [
X.BI \-o\| output_file
X] [
X.B \-R
X] [
X.B \-S
X] [
X.B \-v
X] [ file... ]
X.SH DESCRIPTION
X.I Findsrc
Xrecursively examines all directories and files specified on the command
Xline, and determines, based on the file name, whether the file contains
Xsource code or not.
XAll directories are listed first, followed by all regular files,
Xwith one item per line.
X.PP
XIf
X.I findsrc
Xis unable to make a decision, it invokes the
X.IR file (1)
Xcommand, and prompts the user for a decision.
XIn reply to the prompt, type the letter ``y'' or ``n'' (either case);
XRETURN means yes.
XIf the reply starts with an exclamation point, the rest of the line
Xis passed off to a sub-shell and the question is repeated.
XThe ``\-d'' option may be used with an argument of ``y'' or ``n''
Xto by-pass the interaction, and provide a default answer.
X.PP
XThe ``\-o'' option may be used to specify an output filename.
XThis is designed to prevent confusion if a command like the following
Xis executed:
X.RS
Xfindsrc . * >LIST
X.RE
X.PP
XBy default,
X.I findsrc
Xignores files whose names begin with a period, like ``.newsrc'' or
X``.tags''; such files may be included by using the ``\-.'' option.
X.I Findsrc
Xalso normally ignores
XRCS and SCCS files and directories; using either the ``\-R'' or ``\-S''
Xoption causes both to be included.
X.PP
X.I Findsrc
Xnormally lists only the names of those files that have been selected.
XIf the ``\-v'' option is used, rejected files are also listed preceeded
Xby the word ``PUNTED.''
X.PP
XIf no files are specified on the command line, the program operates as
Xa filter, reading a list of files and directories from the standard
Xinput, one per line.
X.SH "SEE ALSO"
Xmakekit(1l).
END_OF_FILE
if test 1859 -ne `wc -c <'findsrc.man'`; then
    echo shar: \"'findsrc.man'\" unpacked with wrong size!
fi
# end of 'findsrc.man'
fi
if test -f 'glue.c' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'glue.c'\"
else
echo shar: Extracting \"'glue.c'\" \(1239 characters\)
sed "s/^X//" >'glue.c' <<'END_OF_FILE'
X/*
X**  Subroutine to call the shell archive parser.  This is "glue"
X**  between unshar and the parser proper.
X*/
X#include "shar.h"
X#ifdef	RCSID
Xstatic char RCS[] =
X	"$Header: glue.c,v 2.0 88/05/27 13:26:14 rsalz Exp $";
X#endif	/* RCSID */
X
X
X#ifdef	USE_MY_SHELL
X/*
X**  Cleanup routine after BinSh is done
X*/
Xvoid
XBSclean()
X{
X    (void)fclose(Input);
X    (void)unlink(File);
X}
X
X
X/*
X**  Copy the input to a temporary file, then call the shell parser.
X*/
XBinSh(Name, Stream, Pushback)
X    char		*Name;
X    REGISTER FILE	*Stream;
X    char		*Pushback;
X{
X    REGISTER FILE	*F;
X    char		 buff[BUFSIZ];
X    char		*vec[MAX_WORDS];
X
X    Interactive = Name == NULL;
X#ifdef	MSDOS
X    File = "shell.XXX";
X    onexit(BSclean);
X#else
X    File = mktemp("/tmp/shellXXXXXX");
X#endif	/* MSDOS */
X
X    F = fopen(File, "w");
X    (void)fputs(Pushback, F);
X    while (fgets(buff, sizeof buff, Stream))
X	(void)fputs(buff, F);
X    (void)fclose(Stream);
X
X    if ((Input = fopen(TEMP, "r")) == NULL)
X	Fprintf(stderr, "Can't open %s, %s!?\n", TEMP, Ermsg(errno));
X    else
X	while (GetLine(TRUE)) {
X#ifdef	MSDOS
X	    if (setjmp(jEnv))
X		break;
X#endif	/* MSDOS */
X	    if (Argify(vec) && Exec(vec) == -FALSE)
X		    break;
X	}
X
X    BSclean();
X}
X#endif	/* USE_MY_SHELL */
END_OF_FILE
if test 1239 -ne `wc -c <'glue.c'`; then
    echo shar: \"'glue.c'\" unpacked with wrong size!
fi
# end of 'glue.c'
fi
if test -f 'lcwd.c' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'lcwd.c'\"
else
echo shar: Extracting \"'lcwd.c'\" \(1110 characters\)
sed "s/^X//" >'lcwd.c' <<'END_OF_FILE'
X/*
X**  Return current working directory.  Something for everyone.
X*/
X/* LINTLIBRARY */
X#include "shar.h"
X#ifdef	RCSID
Xstatic char RCS[] =
X	"$Header: lcwd.c,v 2.0 88/05/27 13:26:24 rsalz Exp $";
X#endif	/* RCSID */
X
X
X#ifdef	PWDGETENV
X/* ARGSUSED */
Xchar *
XCwd(p, i)
X    char	*p;
X    int		 i;
X{
X    char	*q;
X
X    return((q = getenv(PWDGETENV)) ? strcpy(p, q) : NULL);
X}
X#endif	/* PWDGETENV */
X
X
X#ifdef	GETWD
X/* ARGSUSED1 */
Xchar *
XCwd(p, size)
X    char	*p;
X    int		 size;
X{
X    extern char	*getwd();
X
X    return(getwd(p) ? p : NULL);
X}
X#endif	/* GETWD */
X
X
X#ifdef	GETCWD
Xchar *
XCwd(p, size)
X    char	*p;
X    int		 size;
X{
X    extern char	*getcwd();
X
X    return(getcwd(p, size) ? p : NULL);
X}
X#endif	/* GETCWD */
X
X
X#ifdef	PWDPOPEN
Xchar *
XCwd(p, size)
X    char	*p;
X    int		 size;
X{
X    extern FILE	*popen();
X    FILE	*F;
X    int		 i;
X
X    /* This string could be "exec /bin/pwd" if you want... */
X    if (F = popen("pwd", "r")) {
X	if (fgets(p, size, F) && p[i = strlen(p) - 1] == '\n') {
X	    p[i] = '\0';
X	    (void)fclose(F);
X	    return(p);
X	}
X	(void)fclose(F);
X    }
X    return(NULL);
X}
X#endif	/* PWDPOPEN */
END_OF_FILE
if test 1110 -ne `wc -c <'lcwd.c'`; then
    echo shar: \"'lcwd.c'\" unpacked with wrong size!
fi
# end of 'lcwd.c'
fi
if test -f 'lexec.c' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'lexec.c'\"
else
echo shar: Extracting \"'lexec.c'\" \(2062 characters\)
sed "s/^X//" >'lexec.c' <<'END_OF_FILE'
X/*
X**  Process stuff, like fork exec and wait.  Also signals.
X*/
X/* LINTLIBRARY */
X#include "shar.h"
X#include <signal.h>
X#ifdef	RCSID
Xstatic char RCS[] =
X	"$Header: lexec.c,v 2.0 88/05/27 13:26:35 rsalz Exp $";
X#endif	/* RCSID */
X
X
X/* How to fork(), what to wait with. */
X#ifdef	SYS_WAIT
X#include <sys/wait.h>
X#define FORK()		 vfork()
X#define W_VAL(w)	 ((w).w_retcode)
Xtypedef union wait	 WAITER;
X#else
X#define FORK()		 fork()
X#define W_VAL(w)	 ((w) >> 8)
Xtypedef int		 WAITER;
X#endif	/* SYS_WAIT */
X
X
X
X/*
X**  Set up a signal handler.
X*/
XSetSigs(What, Func)
X    int		  What;
X    sigret_t	(*Func)();
X{
X    if (What == S_IGNORE)
X	Func = SIG_IGN;
X    else if (What == S_RESET)
X	Func = SIG_DFL;
X#ifdef	SIGINT
X    if (signal(SIGINT, SIG_IGN) != SIG_IGN)
X	(void)signal(SIGINT, Func);
X#endif	/* SIGINT */
X#ifdef	SIGQUIT
X    if (signal(SIGQUIT, SIG_IGN) != SIG_IGN)
X	(void)signal(SIGQUIT, Func);
X#endif	/* SIGQUIT */
X}
X
X
X/*
X**  Return the process ID.
X*/
Xint
XPid()
X{
X#ifdef	MSDOS
X    return(1);
X#else
X    static int	 X;
X
X    if (X == 0)
X	X = getpid();
X    return(X);
X#endif	/* MSDOS */
X}
X
X
X#ifndef	USE_SYSTEM
X/*
X**  Fork off a command.
X*/
Xint
XExecute(av)
X    char		*av[];
X{
X    REGISTER int	 i;
X    REGISTER int	 j;
X    WAITER		 W;
X
X    if ((i = FORK()) == 0) {
X	SetSigs(S_RESET, (sigret_t (*)())NULL);
X	(void)execvp(av[0], av);
X	perror(av[0]);
X	_exit(1);
X    }
X
X    SetSigs(S_IGNORE, (sigret_t (*)())NULL);
X    while ((j = wait(&W)) < 0 && j != i)
X	;
X    SetSigs(S_RESET, (sigret_t (*)())NULL);
X    return(W_VAL(W));
X}
X
X#else
X
X/*
X**  Cons all the arguments together into a single command line and hand
X**  it off to the shell to execute.
X*/
Xint
XExecute(av)
X    REGISTER char	*av[];
X{
X    REGISTER char	**v;
X    REGISTER char	 *p;
X    REGISTER char	 *q;
X    REGISTER int	 i;
X
X    /* Get length of command line. */
X    for (i = 0, v = av; *v; v++)
X	i += strlen(*v) + 1;
X
X    /* Create command line and execute it. */
X    p = NEW(char, i);
X    for (q = p, v = av; *v; v++) {
X	*q++ = ' ';
X	q += strlen(strcpy(q, *v));
X    }
X
X    return(system(p));
X}
X#endif	/* USE_SYSTEM */
END_OF_FILE
if test 2062 -ne `wc -c <'lexec.c'`; then
    echo shar: \"'lexec.c'\" unpacked with wrong size!
fi
# end of 'lexec.c'
fi
if test -f 'lfiles.c' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'lfiles.c'\"
else
echo shar: Extracting \"'lfiles.c'\" \(1007 characters\)
sed "s/^X//" >'lfiles.c' <<'END_OF_FILE'
X/*
X**  File related routines.
X*/
X/* LINTLIBRARY */
X#include "shar.h"
X#include <sys/stat.h>
X#ifdef	RCSID
Xstatic char RCS[] =
X	"$Header: lfiles.c,v 2.0 88/05/27 13:26:47 rsalz Exp $";
X#endif	/* RCSID */
X
X
X/* Mask of executable bits. */
X#define	EXE_MASK	(S_IEXEC | (S_IEXEC >> 3) | (S_IEXEC >> 6))
X
X/* Stat buffer for last file. */
Xstatic struct stat	 Sb;
X
X
X/*
X**  Stat the file if it's not the one we did last time.
X*/
Xint
XGetStat(p)
X    char		*p;
X{
X    static char		 Name[BUFSIZ];
X
X    if (*p == Name[0] && EQ(p, Name))
X	return(TRUE);
X    return(stat(strcpy(Name, p), &Sb) < 0 ? FALSE : TRUE);
X}
X
X
X/*
X**  Return the file type -- directory or regular file.
X*/
Xint
XFtype(p)
X    char	*p;
X{
X    return(GetStat(p) && ((Sb.st_mode & S_IFMT) == S_IFDIR) ? F_DIR : F_FILE);
X}
X
X
X/*
X**  Return the file size.
X*/
Xoff_t
XFsize(p)
X    char	*p;
X{
X    return(GetStat(p) ? Sb.st_size : 0);
X}
X
X
X/*
X**  Is a file executable?
X*/
Xint
XFexecute(p)
X    char	*p;
X{
X    return(GetStat(p) && (Sb.st_mode & EXE_MASK) ? TRUE : FALSE);
X}
END_OF_FILE
if test 1007 -ne `wc -c <'lfiles.c'`; then
    echo shar: \"'lfiles.c'\" unpacked with wrong size!
fi
# end of 'lfiles.c'
fi
if test -f 'lhost.c' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'lhost.c'\"
else
echo shar: Extracting \"'lhost.c'\" \(1714 characters\)
sed "s/^X//" >'lhost.c' <<'END_OF_FILE'
X/*
X**  Return name of this host.  Something for everyone.
X*/
X/* LINTLIBRARY */
X#include "shar.h"
X#ifdef	RCSID
Xstatic char RCS[] =
X	"$Header: lhost.c,v 2.0 88/05/27 13:27:01 rsalz Exp $";
X#endif	/* RCSID */
X
X
X#ifdef	HOST
Xchar *
XHost()
X{
X    return(HOST);
X}
X#endif	/* HOST */
X
X
X#ifdef	GETHOSTNAME
Xchar *
XHost()
X{
X    static char		 buff[64];
X
X    return(gethostname(buff, sizeof buff) < 0 ? "SITE" : buff);
X}
X#endif	/* GETHOSTNAME */
X
X
X#ifdef	UNAME
X#include <sys/utsname.h>
Xchar *
XHost()
X{
X    static struct utsname	 U;
X
X    return(uname(&U) < 0 ? "SITE" : U.nodename);
X}
X#endif	/* UNAME */
X
X
X#ifdef	UUNAME
Xextern FILE	*popen();
Xchar *
XHost()
X{
X    static char		 buff[50];
X    FILE		*F;
X    char		*p;
X
X    if (F = popen("exec uuname -l", "r")) {
X	if (fgets(buff, sizeof buff, F) == buff && (p = IDX(buff, '\n'))) {
X	    (void)pclose(F);
X	    *p = '\0';
X	    return(buff);
X	}
X	(void)pclose(F);
X    }
X    return("SITE");
X}
X#endif	/* UUNAME */
X
X
X#ifdef	WHOAMI
Xchar *
XHost()
X{
X    static char		 name[64];
X    REGISTER FILE	*F;
X    REGISTER char	*p;
X    char		 buff[100];
X
X    /* Try /etc/whoami; look for a single well-formed line. */
X    if (F = fopen("/etc/whoami", "r")) {
X	if (fgets(name, sizeof name, F) && (p = IDX(name, '\n'))) {
X	    (void)fclose(F);
X	    *p = '\0';
X	    return(name);
X	}
X	(void)fclose(F);
X    }
X
X    /* Try /usr/include/whoami.h; look for #define sysname "foo" somewhere. */
X    if (F = fopen("/usr/include/whoami.h", "r")) {
X	while (fgets(buff, sizeof buff, F))
X	    /* I don't like sscanf, nor do I trust it.  Sigh. */
X	    if (sscanf(buff, "#define sysname \"%[^\"]\"", name) == 1) {
X		(void)fclose(F);
X		return(name);
X	    }
X	(void)fclose(F);
X    }
X    return("SITE");
X}
X#endif /* WHOAMI */
END_OF_FILE
if test 1714 -ne `wc -c <'lhost.c'`; then
    echo shar: \"'lhost.c'\" unpacked with wrong size!
fi
# end of 'lhost.c'
fi
if test -f 'llib.c' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'llib.c'\"
else
echo shar: Extracting \"'llib.c'\" \(3656 characters\)
sed "s/^X//" >'llib.c' <<'END_OF_FILE'
X/*
X**  Some systems will need these routines because they're missing from
X**  their C library.  I put Ermsg() here so that everyone will need
X**  something from this file...
X*/
X/* LINTLIBRARY */
X#include "shar.h"
X#ifdef	RCSID
Xstatic char RCS[] =
X	"$Header: llib.c,v 2.1 88/06/06 22:05:14 rsalz Exp $";
X#endif	/* RCSID */
X
X
X/*
X**  Return the text string that corresponds to errno.
X*/
Xchar *
XErmsg(e)
X    int			 e;
X{
X#ifdef	USE_SYSERRLIST
X    extern int		 sys_nerr;
X    extern char		*sys_errlist[];
X#endif	/* USE_SYSERRLIST */
X    static char		 buff[30];
X
X#ifdef	USE_SYSERRLIST
X    if (e > 0 && e < sys_nerr)
X	return(sys_errlist[e]);
X#endif	/* USE_SYSERRLIST */
X    (void)sprintf(buff, "Error code %d", e);
X    return(buff);
X}
X
X
X#ifdef	NEED_RENAME
X/*
X**  Give the file "from" the new name "to", removing an old "to"
X**  if it exists.
X*/
Xint
Xrename(from, to)
X    char	*from;
X    char	*to;
X{
X    (void)unlink(from);
X    (void)link(to, from);
X    return(unlink(to));
X}
X#endif	/* NEED_RENAME */
X
X
X#ifdef	NEED_MKDIR
X/*
X**  Quick and dirty mkdir routine for them that's need it.
X*/
Xint
Xmkdir(name, mode)
X    char	*name;
X    int		 mode;
X{
X    char	*av[3];
X    int		 i;
X    int		 U;
X
X    av[0] = "mkdir";
X    av[1] = name;
X    av[2] = NULL;
X    U = umask(~mode);
X    i = Execute(av);
X    (void)umask(U);
X    return(i ? -1 : 0);
X}
X#endif	/* NEED_MKDIR */
X
X
X#ifdef	NEED_QSORT
X/*
X**  Bubble sort an array of arbitrarily-sized elements.  This routine
X**  can be used as an (inefficient) replacement for the Unix qsort
X**  routine, hence the name.  If I were to put this into my C library,
X**  I'd do two things:
X**	-Make it be a quicksort;
X**	-Have a front routine which called specialized routines for
X**	 cases where Width equals sizeof(int), sizeof(char *), etc.
X*/
Xqsort(Table, Number, Width, Compare)
X    REGISTER char	 *Table;
X    REGISTER int	  Number;
X    REGISTER int	  Width;
X    REGISTER int	(*Compare)();
X{
X    REGISTER char	 *i;
X    REGISTER char	 *j;
X
X    for (i = &Table[Number * Width]; (i -= Width) >= &Table[Width]; )
X	for (j = i; (j -= Width) >= &Table[0]; )
X	    if ((*Compare)(i, j) < 0) {
X		REGISTER char	*p;
X		REGISTER char	*q;
X		REGISTER int	 t;
X		REGISTER int	 w;
X
X		/* Swap elements pointed to by i and j. */
X		for (w = Width, p = i, q = j; --w >= 0; *p++ = *q, *q++ = t)
X		    t = *p;
X	    }
X}
X#endif	/* NEED_QSORT */
X
X
X#ifdef	NEED_GETOPT
X
X#define TYPE	int
X
X#define ERR(s, c)	if(opterr){\
X	char errbuf[2];\
X	errbuf[0] = c; errbuf[1] = '\n';\
X	(void) write(2, argv[0], (TYPE)strlen(argv[0]));\
X	(void) write(2, s, (TYPE)strlen(s));\
X	(void) write(2, errbuf, 2);}
X
Xextern int strcmp();
X
Xint	opterr = 1;
Xint	optind = 1;
Xint	optopt;
Xchar	*optarg;
X
X/*
X**  Return options and their values from the command line.
X**  This comes from the AT&T public-domain getopt published in mod.sources.
X*/
Xint
Xgetopt(argc, argv, opts)
Xint	argc;
Xchar	**argv, *opts;
X{
X	static int sp = 1;
X	REGISTER int c;
X	REGISTER char *cp;
X
X	if(sp == 1)
X		if(optind >= argc ||
X		   argv[optind][0] != '-' || argv[optind][1] == '\0')
X			return(EOF);
X		else if(strcmp(argv[optind], "--") == NULL) {
X			optind++;
X
X		}
X	optopt = c = argv[optind][sp];
X	if(c == ':' || (cp=IDX(opts, c)) == NULL) {
X		ERR(": illegal option -- ", c);
X		if(argv[optind][++sp] == '\0') {
X			optind++;
X			sp = 1;
X		}
X		return('?');
X	}
X	if(*++cp == ':') {
X		if(argv[optind][sp+1] != '\0')
X			optarg = &argv[optind++][sp+1];
X		else if(++optind >= argc) {
X			ERR(": option requires an argument -- ", c);
X			sp = 1;
X			return('?');
X		} else
X			optarg = argv[optind++];
X		sp = 1;
X	} else {
X		if(argv[optind][++sp] == '\0') {
X			sp = 1;
X			optind++;
X		}
X		optarg = NULL;
X	}
X	return(c);
X}
X
X#endif	/* NEED_GETOPT */
END_OF_FILE
if test 3656 -ne `wc -c <'llib.c'`; then
    echo shar: \"'llib.c'\" unpacked with wrong size!
fi
# end of 'llib.c'
fi
if test -f 'lmem.c' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'lmem.c'\"
else
echo shar: Extracting \"'lmem.c'\" \(579 characters\)
sed "s/^X//" >'lmem.c' <<'END_OF_FILE'
X/*
X**  Get some memory or die trying.
X*/
X/* LINTLIBRARY */
X#include "shar.h"
X#ifdef	RCSID
Xstatic char RCS[] =
X	"$Header: lmem.c,v 2.0 88/05/27 13:27:16 rsalz Exp $";
X#endif	/* RCSID */
X
X
Xalign_t
Xgetmem(i, j)
X    unsigned int	 i;
X    unsigned int	 j;
X{
X    extern char		*calloc();
X    align_t		 p;
X
X    /* Lint fluff:  "possible pointer alignment problem." */
X    if ((p = (align_t)calloc(i, j)) == NULL) {
X	/* Print the unsigned values as int's so ridiculous values show up. */
X	Fprintf(stderr, "Can't Calloc(%d,%d), %s.\n", i, j, Ermsg(errno));
X	exit(1);
X    }
X    return(p);
X}
END_OF_FILE
if test 579 -ne `wc -c <'lmem.c'`; then
    echo shar: \"'lmem.c'\" unpacked with wrong size!
fi
# end of 'lmem.c'
fi
if test -f 'luser.c' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'luser.c'\"
else
echo shar: Extracting \"'luser.c'\" \(727 characters\)
sed "s/^X//" >'luser.c' <<'END_OF_FILE'
X/*
X**  Get user name.  Something for everyone.
X*/
X/* LINTLIBRARY */
X#include "shar.h"
X#ifdef	USE_GETPWUID
X#include <pwd.h>
X#endif	/* USE_GETPWUID */
X#ifdef	RCSID
Xstatic char RCS[] =
X	"$Header: luser.c,v 2.0 88/05/27 13:27:23 rsalz Exp $";
X#endif	/* RCSID */
X
X
X/*
X**  Get user name.  Not secure, but who sends nastygrams as shell archives?
X*/
Xchar *
XUser()
X{
X#ifdef	USE_GETPWUID
X    extern struct passwd	*getpwuid();
X    struct passwd		*p;
X#endif	/* USE_GETPWUID */
X    char			*g;
X
X    if (g = getenv("USER"))
X	return(g);
X    if (g = getenv("LOGNAME"))
X	return(g);
X    if (g = getenv("NAME"))
X	return(g);
X#ifdef	USE_GETPWUID
X    if (p = getpwuid(getuid()))
X	return(p->pw_name);
X#endif	/* USE_GETPWUID */
X    return(USERNAME);
X}
END_OF_FILE
if test 727 -ne `wc -c <'luser.c'`; then
    echo shar: \"'luser.c'\" unpacked with wrong size!
fi
# end of 'luser.c'
fi
if test -f 'patchlevel.h' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'patchlevel.h'\"
else
echo shar: Extracting \"'patchlevel.h'\" \(1274 characters\)
sed "s/^X//" >'patchlevel.h' <<'END_OF_FILE'
X/*
X**  This file records official patches.  RCS records the edit log.
X**
X**  $Header: patchlevel.h,v 2.3 88/06/06 22:04:33 rsalz Exp $
X**
X**  $Log:	patchlevel.h,v $
X**  Revision 2.3  88/06/06  22:04:33  rsalz
X**  patch03:  Fix typo in makekit manpage, and getopt call in the program.
X**  patch03:  Add NEED_RENAME and BACKUP_PREFIX to config.*; edit llib.c
X**  patch03:  and makekit.c to use them.
X**  
X**  Revision 2.2  88/06/03  16:08:37  rsalz
X**  patch02:  Fix order of chdir/mkdir commands for unshar.
X**  
X**  Revision 2.1  88/06/03  12:16:40  rsalz
X**  patch01:  Add config.x386 & config.sVr3; change "dirent.h" to <dirent.h>
X**  patch01:  In Makefile, use $(DIRLIB) only in actions, not dependencies;
X**  patch01:  add /usr/man/local option for MANDIR.
X**  patch01:  Put isascii() before every use of a <ctype.h> macro. 
X**  patch01:  Initialize Flist in shar.c/main().
X**  patch01:  Add -x to synopsis in makekit.man; improve the usage message &
X**  patch01:  put comments around note after an #endif (ANSI strikes again).
X**  patch01:  Remove extraneous declaration of Dispatch[] in parser.c
X**  patch01:  Add missing argument in fprintf call in findsrc.
X**  
X**  Revision 2.0  88/05/27  13:32:13  rsalz
X**  First comp.sources.unix release
X*/
X#define PATCHLEVEL 3
END_OF_FILE
if test 1274 -ne `wc -c <'patchlevel.h'`; then
    echo shar: \"'patchlevel.h'\" unpacked with wrong size!
fi
# end of 'patchlevel.h'
fi
if test -f 'shar.h' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'shar.h'\"
else
echo shar: Extracting \"'shar.h'\" \(3117 characters\)
sed "s/^X//" >'shar.h' <<'END_OF_FILE'
X/*
X**  Header file for shar and friends.
X**  If you have to edit this file, then I messed something up, please
X**  let me know what.
X**
X**  $Header: shar.h,v 2.1 88/06/03 11:39:28 rsalz Exp $
X*/
X
X#include "config.h"
X
X#ifdef	ANSI_HDRS
X#include <stdlib.h>
X#include <stddef.h>
X#include <string.h>
X#include <io.h>
X#include <time.h>
X#else
X#include <stdio.h>
X#ifdef	VMS
X#include <types.h>
X#else
X#include <sys/types.h>
X#endif	/* VMS */
X#include <ctype.h>
X#include <setjmp.h>
X#endif	/* ANSI_HDRS */
X
X#ifdef	IN_SYS_DIR
X#include <sys/dir.h>
X#endif	/* IN_SYS_DIR */
X#ifdef	IN_DIR
X#include <dir.h>
X#endif	/* IN_DIR */
X#ifdef	IN_DIRECT
X#include <direct.h>
X#endif	/* IN_DIRECT */
X#ifdef	IN_SYS_NDIR
X#include <sys/ndir.h>
X#endif	/* IN_SYS_NDIR */
X#ifdef	IN_NDIR
X#include "ndir.h"
X#endif	/* IN_NDIR */
X#ifdef	IN_DIRENT
X#include <dirent.h>
X#endif	/* IN_DIRENT */
X
X
X/*
X**  Handy shorthands.
X*/
X#define TRUE		1
X#define FALSE		0
X#define WIDTH		72
X#define F_DIR		36		/* Something is a directory	*/
X#define F_FILE		65		/* Something is a regular file	*/
X#define S_IGNORE	76		/* Ignore this signal		*/
X#define S_RESET		90		/* Reset signal to default	*/
X
X/* These are used by the archive parser. */
X#define LINE_SIZE	200		/* Length of physical input line*/
X#define MAX_VARS	 20		/* Number of shell vars allowed	*/
X#define MAX_WORDS	 30		/* Make words in command lnes	*/
X#define VAR_NAME_SIZE	 30		/* Length of a variable's name	*/
X#define VAR_VALUE_SIZE	128		/* Length of a variable's value	*/
X
X
X/*
X**  Lint placation.
X*/
X#ifdef	lint
X#undef RCSID
X#undef putchar
X#endif	/* lint */
X#define Fprintf		(void)fprintf
X#define Printf		(void)printf
X
X
X/*
X**  Memory hacking.
X*/
X#define NEW(T, count)	((T *)getmem(sizeof (T), (unsigned int)(count)))
X#define ALLOC(n)	getmem(1, (unsigned int)(n))
X#define COPY(s)		strcpy(NEW(char, strlen((s)) + 1), (s))
X
X
X/*
X**  Macros.
X*/
X#define BADCHAR(c)	(!isascii((c)) || (iscntrl((c)) && !isspace((c))))
X#define HDRCHAR(c)	((c) == '-' || (c) == '_' || (c) == '.')
X#define EQ(a, b)	(strcmp((a), (b)) == 0)
X#define EQn(a, b, n)	(strncmp((a), (b), (n)) == 0)
X#define PREFIX(a, b)	(EQn((a), (b), sizeof b - 1))
X#define WHITE(c)	((c) == ' ' || (c) == '\t')
X
X
X/*
X**  Linked in later.
X*/
Xextern int	 errno;
Xextern int	 optind;
Xextern char	*optarg;
X
X/* From your C run-time library. */
Xextern FILE	*popen();
Xextern time_t	 time();
Xextern long	 atol();
Xextern char	*IDX();
Xextern char	*RDX();
Xextern char	*ctime();
Xextern char	*gets();
Xextern char	*mktemp();
Xextern char	*strcat();
Xextern char	*strcpy();
Xextern char	*strncpy();
Xextern char   	*getenv();
X#ifdef	PTR_SPRINTF
Xextern char	*sprintf();
X#endif	/* PTR_SPRINTF */
X
X/* From our local library. */
Xextern align_t	 getmem();
Xextern off_t	 Fsize();
Xextern char	*Copy();
Xextern char	*Cwd();
Xextern char	*Ermsg();
Xextern char	*Host();
Xextern char	*User();
X
X/* Exported by the archive parser. */
Xextern jmp_buf	 jEnv;
Xextern FILE	*Input;			/* Current input stream		*/
Xextern char	*File;			/* Input filename		*/
Xextern int	 Interactive;		/* isatty(fileno(stdin))?	*/
Xextern void	 SetVar();		/* Shell variable assignment	*/
Xextern void	 SynErr();		/* Fatal syntax error		*/
END_OF_FILE
if test 3117 -ne `wc -c <'shar.h'`; then
    echo shar: \"'shar.h'\" unpacked with wrong size!
fi
# end of 'shar.h'
fi
if test -f 'shar.man' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'shar.man'\"
else
echo shar: Extracting \"'shar.man'\" \(2967 characters\)
sed "s/^X//" >'shar.man' <<'END_OF_FILE'
X.TH SHAR 1l
X.\" $Header: shar.man,v 2.0 88/05/27 13:28:49 rsalz Exp $
X.SH NAME
Xshar \- create shell archive file for extraction by /bin/sh
X.SH SYNOPSIS
X.B shar
X[
X.B \-b
X] [
X.BI \-i\| input_file
X] [
X.BI \-n\| seq_number
X] [
X.BI \-e\| seq_end
X] [
X.BI \-o\| output_file
X] [
X.BI \-t\| final_text
X] [file...]
X.SH DESCRIPTION
X.I Shar
Xtakes a list of files, and generates a
X.IR /bin/sh
Xscript that, when executed, will re-create those files in a different
Xdirectory or on a different machine.
XThe resultant script will use
X.IR wc (1)
Xto do a mild error-check, and will warn about possibly-omitted
Xcontrol characters.
X.PP
X.I Shar
Xgenerates scripts that will make directories and plain files.
XIt will not try to generate intermediate filenames, however, so
X.RS
Xshar foo/bar/file
X.RE
Xwill not work.  Do
X.RS
Xshar foo foo/bar foo/bar/file
X.RE
Xinstead.
X.PP
XThe script is normally sent to standard output; the ``\-o'' option may be
Xused to specify an output filename.
XThis is designed to prevent filling up the disk if
X.RS
Xshar * >SHAR
X.RE
Xcommand is done; do
X.RS
Xshar -o SHAR *
X.RE
Xinstead.
X.PP
XThe list of files is normally specified on the command line; the ''\-i''
Xoption may be used instead, to specify a file that contains the list
Xof files to pack up, one per line.
XIf the file name is ``-'' the standard input is read.
X.PP
XThe ``\-b'' option says that all leading directory names should be stripped
Xfrom the file when they are packed into the archive.
XFor example,
X.RS
Xshar -b /etc/termcap
X.RE
Xcreates an archive that, when executed, creates a file named
X``termcap'' in the current directory, rather than overwrite the
Xhost system file.
XNote, however, that the scripts generated by
X.I shar
Xnormally refuse to overwrite pre-existing files.
X.SS "Multi\-part Archives"
XMost larger software packages are usually sent out in two or more shell
Xarchives.
XThe ``\-n,'' ``\-e,'' and ``\-t'' options are used to make an archive
Xthat is part of a series.
XThe individual archives are often called ``kits'' when this is done.
XThe ``\-n'' option specifies the archive number; the ``\-e'' option species
Xthe highest number in the series.
XWhen executed, the generated archives will then echo messages like
X.RS
Xshar: End of archive 3 of 9.
X.RE
Xat their end.
X.PP
XIn addition, each shar will generate a file named
X.IR ark X isdone .
XEach script will contain a loop to check for the presence of these
Xfiles, and indicate to the recipient which archives still need to be
Xexecuted.
XThe ``\-t'' option may be used to give starting instructions to the recipient.
XWhen the scripts determine that all the archives have been unpacked,
Xthe text specified with this flag is displayed.
XFor example,
X.RS
Xshar -n1 -k9 -t "Now do 'sh ./Configure'" *.c >SHAR
X.RE
XAdds commands to output the following when all the archives have been unpacked:
X.RS
X.nf
XYou have run all 9 archives.
XNow do 'sh ./Configure'
X.fi
X.RE
X.SH "SEE ALSO"
Xecho(1), findsrc(1l), makekit(1l), mkdir(1), sh(1), test(1), unshar(1l),
Xwc(1).
END_OF_FILE
if test 2967 -ne `wc -c <'shar.man'`; then
    echo shar: \"'shar.man'\" unpacked with wrong size!
fi
# end of 'shar.man'
fi
if test -f 'shell.c' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'shell.c'\"
else
echo shar: Extracting \"'shell.c'\" \(808 characters\)
sed "s/^X//" >'shell.c' <<'END_OF_FILE'
X/*
X**  Stand-alone driver for shell.
X*/
X#include "shar.h"
X#ifdef	RCSID
Xstatic char RCS[] =
X	"$Header: shell.c,v 2.0 88/05/27 13:28:06 rsalz Exp $";
X#endif	/* RCSID */
X
X
Xmain(ac, av)
X    REGISTER int	 ac;
X    REGISTER char	*av[];
X{
X    char		*vec[MAX_WORDS];
X    char		 buff[VAR_VALUE_SIZE];
X
X    if (Interactive = ac == 1) {
X	Fprintf(stderr, "Testing shell interpreter...\n");
X	Input = stdin;
X	File = "stdin";
X    }
X    else {
X	if ((Input = fopen(File = av[1], "r")) == NULL)
X	    SynErr("UNREADABLE INPUT");
X	/* Build the positional parameters. */
X	for (ac = 1; av[ac]; ac++) {
X	    (void)sprintf(buff, "%d", ac - 1);
X	    SetVar(buff, av[ac]);
X	}
X    }
X
X    /* Read, parse, and execute. */
X    while (GetLine(TRUE))
X	if (Argify(vec) && Exec(vec) == -FALSE)
X	    break;
X
X    /* That's it. */
X    exit(0);
X}
END_OF_FILE
if test 808 -ne `wc -c <'shell.c'`; then
    echo shar: \"'shell.c'\" unpacked with wrong size!
fi
# end of 'shell.c'
fi
if test -f 'shell.man' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'shell.man'\"
else
echo shar: Extracting \"'shell.man'\" \(1090 characters\)
sed "s/^X//" >'shell.man' <<'END_OF_FILE'
X.TH SHELL 1l
X.\" $Header: shell.man,v 2.0 88/05/27 13:28:55 rsalz Exp $
X.SH NAME
Xshell \- Interpreter for shell archives
X.SH SYNOPSIS
X.B shell
X[ file...  ]
X.SH DESCRIPTION
XThis program interprets enough UNIX shell syntax, and command usage,
Xto enable it to unpack many different types of UNIX shell archives,
Xor ``shar's.''
XIt is primarily intended to be used on non-UNIX systems that need to
Xunpack such archives.
X.PP
X.I Shell
Xdoes
X.B not
Xcheck for security holes, and will blithely execute commands like
X.RS
Xcp /dev/null /etc/passwd
X.RE
Xwhich, if executed by the super-user, can be disastrous.
X.PP
XThe
X.I shell
Xparser is line-based, where lines are then split into tokens; it is not a
Xtrue token-based parser.
XIn general, it is best if all
X.I sh
Xkeywords that can appear alone on a line do so, and that compound
Xcommands (i.e., using a semi-colon) be avoided.
XFor more details on the syntax, see the source (sorry...).
X.SH BUGS
XIt is probably easier to write a true portable replacement for /bin/sh
Xthan it is to write something which understands all shar formats.
X.SH SEE ALSO
Xshar(1l).
END_OF_FILE
if test 1090 -ne `wc -c <'shell.man'`; then
    echo shar: \"'shell.man'\" unpacked with wrong size!
fi
# end of 'shell.man'
fi
if test -f 'unshar.man' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'unshar.man'\"
else
echo shar: Extracting \"'unshar.man'\" \(2326 characters\)
sed "s/^X//" >'unshar.man' <<'END_OF_FILE'
X.TH UNSHAR 1l
X.\" $Header: unshar.man,v 2.0 88/05/27 13:29:02 rsalz Exp $
X.SH NAME
Xunshar \- unpack shell archives from news, mail, notes, etc.
X.SH SYNOPSIS
X.B unshar
X[
X.BI \-c\| directory
X] [
X.BI \-d\| directory
X] [
X.BI \-h\| file
X] [
X.B \-f
X] [
X.B \-n
X] [
X.B \-s
X] [ file... ]
X.SH DESCRIPTION
X.I Unshar
Xremoves mail and news header lines from its input, and feeds the remainder
Xto
X.IR /bin/sh (1)
Xso that a shell archive can be properly unpacked.
XIf no files are specified,
X.I unshar
Xreads from standard input.
XThe program is designed to be useful when unpacking archives directly
Xfrom the news or mail systems (e.g., s | unshar).
X.PP
X.I Unshar
Xnormally unpacks its files in the current directory.
XUse the ``\-c'' option to have the program change to a new directory
Xbefore invoking the shell.
XIf the directory does not exist, it will try to create it.
XIf the directory name starts with a question mark, then
X.I unshar
Xwill ask for the directory name before doing anything; this is most useful
Xwith the environment variable UNSHAREDIR.
XIf the directory name starts with a tilde, then the value of the HOME
Xenvironment variable is inserted in place of that character.
XFor convenience, the ``\-d'' option is a synonym for the ``\-c'' option.
X.PP
X.I Unshar
Xnormally complains if the input looks like something other than a shar file.
X(Among other things, it checks for files that resemble C, and Pascal code).
XIt can be fooled, however, by nonstandard versions of news, notes, etc.
XThe ``\-f'' option forces
X.I unshar
Xto try unpacking files, even if they look like something else.
X.PP
XDepending on how the program is installed,
X.I unshar
Xmay or may not try to preserve the header part of file ``foo''
Xinto the name ``foo.hdr'' (if the file is standard input, the name
Xwill be ``UNSHAR.HDR'').
XUsing the ``\-s'' option forces the program to save the headers, while
Xusing the ``\-n'' option forces it to discard the headers.
XThe file is appended to, if it already exists, so all headers can be easily
Xsaved in one file.
XThe name of the file may be given by using the ``\-h'' option; this is
Xparticularly useful when processing more than one file at a time.
X.SH ENVIRONMENT
X.ta \w'UNSHAREDIR  'u
XHOME	Value used if a leading tilde is given in directory name.
X.br
XUNSHAREDIR	Default value for ``\-c'' option.
X.SH SEE ALSO
Xshar(1).
END_OF_FILE
if test 2326 -ne `wc -c <'unshar.man'`; then
    echo shar: \"'unshar.man'\" unpacked with wrong size!
fi
# end of 'unshar.man'
fi
echo shar: End of archive 1 \(of 3\).
cp /dev/null ark1isdone
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
