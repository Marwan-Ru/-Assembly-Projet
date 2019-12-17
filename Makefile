ASOPTIONS = -a --gstabs

cv1 : clean cv1.o atoi.o print.o printC.o
	ld cv1.o atoi.o print.o printC.o -o cv1 

cv1.o : cv1.s
	as $(ASOPTIONS) -o cv1.o cv1.s

cv2 : clean cv2.o atoi.o print.o printC.o
	ld cv2.o atoi.o print.o printC.o -o cv2

cv2.o : cv2.s
	as $(ASOPTIONS) -o cv2.o cv2.s

cv3 : clean cv3.o atoi.o print.o printC.o
	ld cv3.o atoi.o print.o printC.o -o cv3

cv3.o : cv3.s
	as $(ASOPTIONS) -o cv3.o cv3.s

cv4 : clean cv4.o atoi.o print.o printC.o
	ld cv4.o atoi.o print.o printC.o -o cv4

cv4.o : cv4.s
	as $(ASOPTIONS) -o cv4.o cv4.s

clean : 
	rm -f cv1.o cv1 cv2.o cv2  cv3.o cv3 cv4.o cv4
