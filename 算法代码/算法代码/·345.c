//
//  main.c
//  算法代码
//
//  Created by 唐仁于 on 2017/12/20.
//  Copyright © 2017年 唐仁于. All rights reserved.
//

#include <stdio.h>

int main(int argc, const char * argv[]) {
    
    // insert code here...
    printf("Hello, World!\n");
    void PrintDigit( unsigned int N);
//    int F(int X);
//    printf("递归结果===%d\n",F(12));
    void PrintOut (unsigned int N );
    PrintOut(1234);
//    F(12);
    return 0;
}
int F( int X){
    if (X == 0) {
        return 0;
    }else{
        return 2 * F(X - 1) + X*X;
    }
    
}

void PrintOut (unsigned int N ){
    if ( N>=10){
        PrintOut(N/10);
    }
        void PrintDigit( unsigned int N);
        PrintDigit(N%10);
}
void PrintDigit( unsigned int N){
    
    printf("%d",N);
}
