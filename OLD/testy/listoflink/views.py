from django.shortcuts import render

# Create your views here.
def catView(request):
    return render(request,'listoflink/cat.html')

    
def dogView(request):
    return render(request,'listoflink/dog.html')
