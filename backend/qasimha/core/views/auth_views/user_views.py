from django.shortcuts import render
from rest_framework import generics
from core.models import *
from core.serializers import *
from rest_framework import viewsets

# Create your viewsets here.
class UserViewset(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer

class FeedbackViewset(viewsets.ModelViewSet):
    queryset = Feedback.objects.all()
    serializer_class = FeedbackSerializer