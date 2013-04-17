HOSTCC:=$(CC)
CC:=$(CROSS_COMPILE)$(HOSTCC)
CFLAGS:=-std=c99 -Wall -O2 $(CFLAGS) -I extra/include

HOSTLD:=$(LD)
LD:=$(CROSS_COMPILE)$(HOSTLD)
LDFLAGS:=-L extra/lib

TEMPER_OBJS:=comm.o

all:	libtemper2.so

%.o:	%.c
	$(CC) -c $(CFLAGS) -fPIC -DUNIT_TEST -o $@ $^

libtemper2.so:		$(TEMPER_OBJS) 
	$(CC) -fPIC -lusb -shared -o $@ $^

clean:		
	rm -f temper *.o libtemper2.so

rules-install:			# must be superuser to do this
	cp 99-tempsensor.rules /etc/udev/rules.d

install:
	cp libtemper2.so /usr/lib/

