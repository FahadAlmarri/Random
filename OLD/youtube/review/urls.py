from importlib.resources import path
from unicodedata import name
from . import views
from django.urls import path


app_name='review'
urlpatterns = [
    path('review/',views.review,name='review'),
    path("thanks/",views.thanks,name='thanks')
]
