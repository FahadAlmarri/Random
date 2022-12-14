# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models

class User(models.Model):
    user_id = models.AutoField(db_column='User_ID', primary_key=True)  # Field name made lowercase.
    user_email = models.CharField(db_column='User_email', unique=True, max_length=255)  # Field name made lowercase.
    username = models.CharField(db_column='Username', max_length=45)  # Field name made lowercase.
    password_hash = models.CharField(db_column='Password_hash', max_length=255)  # Field name made lowercase.
    first_name = models.CharField(db_column='First_name', max_length=45)  # Field name made lowercase.
    last_name = models.CharField(db_column='Last_name', max_length=45)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'user'

class Sample(models.Model):
    sample_id = models.AutoField(db_column='Sample_ID', primary_key=True)  # Field name made lowercase.
    user = models.ForeignKey('User', models.DO_NOTHING, db_column='User_ID', blank=True, null=True)  # Field name made lowercase.
    report = models.ForeignKey("Report", models.DO_NOTHING, db_column='Report_ID', blank=True, null=True)  # Field name made lowercase.
    sample_address = models.CharField(db_column='Sample_Address', max_length=255, blank=True, null=True)  # Field name made lowercase.
    privacy_type = models.CharField(db_column='Privacy_Type', max_length=45, blank=True, null=True)  # Field name made lowercase.
    create_date = models.DateTimeField(db_column='Create_Date', blank=True, null=True)  # Field name made lowercase.
    sample_type = models.CharField(db_column='Sample_Type', max_length=45, blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'sample'


class Report(models.Model):
    report_id = models.AutoField(db_column='Report_ID', primary_key=True)  # Field name made lowercase.
    behavior = models.CharField(db_column='Behavior', max_length=45, blank=True, null=True)  # Field name made lowercase.
    signature = models.CharField(db_column='Signature', max_length=255, blank=True, null=True)  # Field name made lowercase.
    network = models.CharField(db_column='Network', max_length=255, blank=True, null=True)  # Field name made lowercase.
    metadata = models.CharField(db_column='Metadata', max_length=255, blank=True, null=True)  # Field name made lowercase.
    others = models.CharField(db_column='Others', max_length=255, blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'report'