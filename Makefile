CC= clang++
CFLAGS= -I/usr/local/include/ 
LIBS= -L/usr/local/lib/ -lSDL2

main.o: main.cpp
	$(CC) $(CFLAGS) -c $< -o $@

app: main.o 
	$(CC) main.o -o app $(LIBS)

all: app


clean:
	[ -f ./app ] && rm ./app || echo "file dosn't not exist"
	[ -f ./main.o ] && rm ./main.o || echo "file dosn't not exist"
