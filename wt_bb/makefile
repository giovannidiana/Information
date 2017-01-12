
CC = g++

EXECUTABLES = CCap  

OBJECT_FILES = MInfo.o

all: $(EXECUTABLES)

$(EXECUTABLES): % : %.cpp $(OBJECT_FILES)
	$(CC) $(CFLAGS) -o $@ $< $(OBJECT_FILES) 

$(OBJECT_FILES): %.o : %.cpp 
	$(CC) $(CFLAGS) -c $<

clean:
	rm -f *.o
	rm -f $(EXECUTABLES)



	
