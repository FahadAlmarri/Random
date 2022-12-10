from django.urls import path
from . import views


app_name='hotelreserve'

urlpatterns = [
    
    path('',views.mainPage,name='mainPage'),
    path('reservePage',views.reservePage,name='reservePage'),
    path('myRooms',views.myRooms,name='myRooms'),
    path('reserveRoom',views.reserveRoom,name='reserveRoom'),
]
