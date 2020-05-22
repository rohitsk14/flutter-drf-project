from django.shortcuts import render
from rest_framework.response import Response
from .models import Card
from .serializers import CardSerializer
from rest_framework import viewsets
from rest_framework import  mixins

# Create your views here.
class Details(viewsets.ModelViewSet):
    serializer_class = CardSerializer
    queryset = Card.objects.all()
