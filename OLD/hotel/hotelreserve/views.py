from multiprocessing import context
from django.shortcuts import render

# Create your views here.
def reservePage(request):
    context={'firstName':'fahad'}
    return render(request,'hotelreserve/reservePage.html',context=context)


def reserveRoom(request):
    return render(request,'hotelreserve/reserveRoom.html')

def myRooms(request):
    return render(request,'hotelreserve/myRooms.html')

def mainPage(request):
    return render(request,'hotelreserve/main.html')