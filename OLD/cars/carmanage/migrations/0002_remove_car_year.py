# Generated by Django 4.0.3 on 2022-08-21 11:58

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('carmanage', '0001_initial'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='car',
            name='year',
        ),
    ]