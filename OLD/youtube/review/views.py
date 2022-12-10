from django.shortcuts import render,redirect
from .forms import reviewform
from django.urls import reverse
# Create your views here.
def review(request):
    if(request.method=='POST'):
        form=reviewform(request.POST)
        if(form.is_valid()):
            print(form.cleaned_data)
            return redirect(reverse('review:thanks'))
    else:
        dic={'reviewForm':reviewform}
        return render(request,'review/review.html',context=dic)
def thanks(request):
    return render(request,'review/thanku.html')