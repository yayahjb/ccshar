/*
**  Get some memory or die trying.
*/
/* LINTLIBRARY */
#include "shar.h"
#ifdef	RCSID
static char RCS[] =
	"$Header: /Users/yaya/ccshar/RCS/lmem.c,v 1.1 2005/08/03 02:31:07 root Exp root $";
#endif	/* RCSID */


align_t
getmem(i, j)
    unsigned int	 i;
    unsigned int	 j;
{
#ifndef HAVE_STDLIB
    extern char		*calloc();
#endif
    align_t		 p;

    /* Lint fluff:  "possible pointer alignment problem." */
    if ((p = (align_t)calloc(i, j)) == NULL) {
	/* Print the unsigned values as int's so ridiculous values show up. */
	Fprintf(stderr, "Can't Calloc(%d,%d), %s.\n", i, j, Ermsg(errno));
	exit(1);
    }
    return(p);
}
