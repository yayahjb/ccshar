/*
**  Get user name.  Something for everyone.
*/
/* LINTLIBRARY */
#include "shar.h"
#ifdef	USE_GETPWUID
#include <pwd.h>
#endif	/* USE_GETPWUID */
#ifdef	RCSID
static char RCS[] =
	"$Header: /Users/yaya/ccshar/RCS/luser.c,v 1.1 2005/08/03 02:31:07 root Exp root $";
#endif	/* RCSID */


/*
**  Get user name.  Not secure, but who sends nastygrams as shell archives?
*/
char *
User()
{
#ifdef	USE_GETPWUID
    extern struct passwd	*getpwuid();
    struct passwd		*p;
#endif	/* USE_GETPWUID */
    char			*g;

    if (g = getenv("USER"))
	return(g);
    if (g = getenv("LOGNAME"))
	return(g);
    if (g = getenv("NAME"))
	return(g);
#ifdef	USE_GETPWUID
    if (p = getpwuid(getuid()))
	return(p->pw_name);
#endif	/* USE_GETPWUID */
    return(USERNAME);
}
