from django.urls import path
from .views import  CarsCreateViewAndList ,ThankUTemplateView,HomeTemplate
app_name='carmanage'
urlpatterns = [
    path('create/',CarsCreateViewAndList.as_view(),name='create'),
    path('thanku/',ThankUTemplateView.as_view(),name='thanku'),
    path('',HomeTemplate.as_view(),name='home')
]
