
CC = g++

EXECUTABLES = CCap CCap3D CCap2D CCap1D GetMI2D GetMI1D GetMI1D_f2D GetMI3D GetSC GetNC CCapLS GetShuffle 

OBJECT_FILES = MInfo.o

all: $(EXECUTABLES)

$(EXECUTABLES): % : %.cpp $(OBJECT_FILES)
	$(CC) $(CFLAGS) -o $@ $< $(OBJECT_FILES) -lgsl -lblas

$(OBJECT_FILES): %.o : %.cpp 
	$(CC) $(CFLAGS) -c $<

clean:
	rm -f *.o
	rm -f $(EXECUTABLES)



	
