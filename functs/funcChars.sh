#!/bin/bash

upper() {
# turns any lower case letters to uppercase.
# Usage: UPPERWORDS=$(upper lowercase words)
# for example, if you need to change y to Y
  for WORD in $@
  do
    LEN=$(echo $WORD | wc -c)
    I=1
    while [ $I -lt $LEN ]
    do
      CHAR=$(echo $WORD | cut -c$I)
      I=$(expr $I + 1)
      case $CHAR in
        a) CHAR=A ;;
        b) CHAR=B ;;
        c) CHAR=C ;;
        d) CHAR=D ;;
        e) CHAR=E ;;
        f) CHAR=F ;;
        g) CHAR=G ;;
        h) CHAR=H ;;
        i) CHAR=I ;;
        j) CHAR=J ;;
        k) CHAR=K ;;
        l) CHAR=L ;;
        m) CHAR=M ;;
        n) CHAR=N ;;
        o) CHAR=O ;;
        p) CHAR=P ;;
        q) CHAR=Q ;;
        r) CHAR=R ;;
        s) CHAR=S ;;
        t) CHAR=T ;;
        u) CHAR=U ;;
        v) CHAR=V ;;
        w) CHAR=W ;;
        y) CHAR=Y ;;
        z) CHAR=Z ;;
      esac
      UPPER="${UPPER}${CHAR}"  
    done
    UPPER="$UPPER "  
  done
  echo $UPPER
}

lower() {
# turns any upper case letters to lower case.
# Usage: LOWERWORDS=$(lower Word1 WorD2 words)
  for WORD in $@
  do
    LEN=$(echo $WORD | wc -c)
    I=1
    while [ $I -lt $LEN ]
    do
      CHAR=$(echo $WORD | cut -c$I)
      I=$(expr $I + 1)
      case $CHAR in
        A) CHAR=a ;;
        B) CHAR=b ;;
        C) CHAR=c ;;
        D) CHAR=d ;;
        E) CHAR=e ;;
        F) CHAR=f ;;
        G) CHAR=g ;;
        H) CHAR=h ;;
        I) CHAR=i ;;
        J) CHAR=j ;;
        K) CHAR=k ;;
        L) CHAR=l ;;
        M) CHAR=m ;;
        N) CHAR=n ;;
        O) CHAR=o ;;
        P) CHAR=p ;;
        Q) CHAR=q ;;
        R) CHAR=r ;;
        S) CHAR=s ;;
        T) CHAR=t ;;
        U) CHAR=u ;;
        V) CHAR=v ;;
        W) CHAR=w ;;
        Y) CHAR=y ;;
        Z) CHAR=z ;;
      esac
      LOWER="${LOWER}${CHAR}"  
    done
    LOWER="$LOWER "  
  done
  echo $LOWER
}
