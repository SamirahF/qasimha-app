from django.shortcuts import render
from rest_framework import generics
from core.models import *
from qasimha.core.serializers import *
# Create your views here.
class UserLisrCreate (generics.ListAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer

