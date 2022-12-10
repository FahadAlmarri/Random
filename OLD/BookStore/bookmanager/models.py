

from django.db import models

# Create your models here.
class book_base(models.Model):
    book_name=models.CharField(max_length=50)
    auther=models.CharField(max_length=60)
    