from django.contrib.auth import authenticate, get_user_model
from core.models import *
from core.serializers import *
from rest_framework import viewsets
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework import status

User = get_user_model()

# Create your viewsets here.
class UserViewset(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer

    @action(detail=False, methods=['post'], url_path='login')
    def login_user(self,request):
        email = request.data.get('email')
        password = request.data.get('password')
        try:
                user = User.objects.get(email=email)
                print(user.password)
                print(user.username)
                print("authentication with username:" , authenticate(username =user.username, password=password))
                if user is not None:
                    print(user)
                    serializer = UserSerializer(user)
                    return Response(serializer.data)
                else:
                    return Response({"error": "Invalid credentials"}, status=status.HTTP_401_UNAUTHORIZED)
        except User.DoesNotExist:
                return Response({"error": "Invalid email"}, status=status.HTTP_401_UNAUTHORIZED)

class FeedbackViewset(viewsets.ModelViewSet):
    queryset = Feedback.objects.all()
    serializer_class = FeedbackSerializer