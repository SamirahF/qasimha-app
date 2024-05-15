from django.shortcuts import render
from rest_framework import generics
from core.models import *
from core.serializers import *
from rest_framework import viewsets

# Create your views here.

class UserLisrCreate (generics.ListAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer


class UserViewset(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer

