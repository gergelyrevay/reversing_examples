/* hello0.c -- hello, world! */
 
#include <sys/types.h>
#include <sys/uio.h>
#include <unistd.h>
 
const char *msg = "hello, world!\n";
 
int
main (int argc, char *argv[])
{
  write(1, msg, 14);
 
  return 0;
}