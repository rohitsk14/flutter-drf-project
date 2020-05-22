from django.db import models

# Create your models here.
class Card(models.Model):
    name = models.CharField(max_length=50)
    number = models.CharField(max_length=15)

    def __str__(self):
        return self.name