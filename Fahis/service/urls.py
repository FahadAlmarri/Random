from django.urls import path
from . import views
urlpatterns = [
    path("",views.Fahis,name="Fahis"),
    path("previos",views.previos,name="previos")

]
