from django import forms

class reviewform(forms.Form):
    name=forms.CharField(max_length=20, required=False)
    review=forms.CharField( max_length=300, required=False)
    
