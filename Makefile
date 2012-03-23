SRC=src
INC=include
LIB=.
CLIENT=client

CC=gcc
CCFLAGS=-I$(INC) -Wall -O
LDFLAGS=-L$(LIB) -lemqtt
AR=ar

all: $(CLIENT)/pub $(CLIENT)/sub

$(CLIENT)/pub: libemqtt.a pub.o
	$(CC) pub.o -o $(CLIENT)/pub $(LDFLAGS)

pub.o: $(CLIENT)/pub.c $(INC)/libemqtt.h
	$(CC) $(CCFLAGS) -c $(CLIENT)/pub.c -o pub.o

$(CLIENT)/sub: libemqtt.a sub.o
	$(CC) sub.o -o $(CLIENT)/sub $(LDFLAGS)

sub.o: $(CLIENT)/sub.c $(INC)/libemqtt.h
	$(CC) $(CCFLAGS) -c $(CLIENT)/sub.c -o sub.o

libemqtt.a: libemqtt.o
	$(AR) rcs libemqtt.a libemqtt.o

libemqtt.o: $(SRC)/libemqtt.c $(INC)/libemqtt.h
	$(CC) $(CCFLAGS) -c $(SRC)/libemqtt.c -o libemqtt.o

clean:
	rm -f libemqtt.o libemqtt.a pub.o sub.o

dist-clean: clean
	rm -f $(CLIENT)/pub $(CLIENT)/sub
