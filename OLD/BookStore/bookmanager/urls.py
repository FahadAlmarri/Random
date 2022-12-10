import imp
from django.urls import path
from . import views

app_name='bookmanager'

urlpatterns = [
    path('formTemplate/',views.bookEnterer,name='formtemplate')
]
