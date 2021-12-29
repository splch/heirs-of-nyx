CC=/home/spence/Documents/gbdk-2020/build/gbdk/bin/lcc
CFLAGS=-Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG
GB=sameboy
GFLAGS=--nogl
DEPS = main.c

mainmake: $(DEPS)
	@$(CC) $(CFLAGS) -c -o main.o main.c
	@$(CC) $(CFLAGS) -o Pirates\ Folly.gb main.o
	@$(GB) $(GFLAGS) Pirates\ Folly.gb

clean:
	@rm main.asm main.ihx main.lst main.map main.noi main.o main.sym
