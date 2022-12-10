from django.urls import path
from . import views



urlpatterns = [
    path('cat/',views.catView),
    path('dog',views.dogView),
]
