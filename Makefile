ASOPTIONS = -a --gstabs

cv1 : clean cv1.o atoi.o print.o printC.o
	ld cv1.o atoi.o print.o printC.o -o cv1 

cv1.o : cv1.s
	as $(ASOPTIONS) -o cv1.o cv1.s

cv2 : clean cv2.o atoi.o print.o printC.o
	ld cv2.o atoi.o print.o printC.o -o cv2

cv2.o : cv2.s
	as $(ASOPTIONS) -o cv2.o cv2.s

clean : 
	rm -f cv1.o cv1 cv2.o cv2
