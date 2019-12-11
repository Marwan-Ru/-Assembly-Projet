ASOPTIONS = -a --gstabs

cv1.s : clean cv1.o atoi.o
	ld cv1.o atoi.o -o cv1 

cv1.o : cv1.s
	as $(ASOPTIONS) -o cv1.o cv1.s

clean : 
	rm -f cv1.o cv1
