from dataclasses import field
from msilib.schema import ListView
from multiprocessing import context
from django.shortcuts import render
from django.views.generic import CreateView,TemplateView,ListView
from .models import Car
from django.urls import reverse_lazy
# Create your views here.
class CarsCreateViewAndList(CreateView):
    template_name= 'carmanage/car_form.html'
    model= Car
    fields="__all__"
    success_url=reverse_lazy('carmanage:create')
    def get_context_data(self, **kwargs):
        context=super().get_context_data(**kwargs)
        context['Cars']=Car.objects.all
        return context

class ThankUTemplateView(TemplateView):
    template_name= 'carmanage/thanku.html'

    
class HomeTemplate(TemplateView):
    template_name ='carmanage/home.html'