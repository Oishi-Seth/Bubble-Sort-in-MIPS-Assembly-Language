#include<iostream>
#include<bits/stdc++.h>
using namespace std;

void Bubblesort (int A[], int n)
{
  	int i, j;
  	int t;
  	for (i = 0; i < n - 2; ++i)
    		for (j = 0; j < n - 1 - i; ++j)
      			if (A[j] > A[j + 1])
			{
	  			t = A[j];
	  			A[j] = A[j + 1];
	  			A[j + 1] = t;
			}
}


int main()
{
	int n;
	cin >> n;
	int A[n];
	for(int i=0; i<n; i++)
		cin >> A[i];
	Bubblesort(A, n);
	for(int i=0; i<n; i++)
		cout << A[i] << " ";
	return 0;
}
	
