from django.contrib.auth import authenticate, get_user_model
from core.models import *
from core.serializers import *
from rest_framework import viewsets
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework import status
from django.contrib.auth.hashers import check_password

User = get_user_model()

# Create your viewsets here.
class UserViewset(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer

    def create(self, request, *args, **kwargs):
        data = request.data.copy()
        user = User(
            username=data.get('username'),
            email=data.get('email'),
            first_name=data.get('first_name'),
            last_name=data.get('last_name')
        )
        user.set_password(data.get('password'))  # Hash the password
        user.save()
        serializer = UserSerializer(user)
        return Response(serializer.data, status=status.HTTP_201_CREATED)

    @action(detail=False, methods=['post'], url_path='login')
    def login_user(self,request):
        email = request.data.get('email')
        password = request.data.get('password')
        try: 
                user = User.objects.get(email=email)
                print(check_password(password, user.password))
                print("authentication with username:" , authenticate(username =user.username, password=password))
                if user is not None:
                    # print(user)
                    serializer = UserSerializer(user)
                    return Response(serializer.data)
                else:
                    return Response({"error": "Invalid credentials"}, status=status.HTTP_401_UNAUTHORIZED)
        except User.DoesNotExist:
                return Response({"error": "Invalid email"}, status=status.HTTP_401_UNAUTHORIZED)

class FeedbackViewset(viewsets.ModelViewSet):
    queryset = Feedback.objects.all()
    serializer_class = FeedbackSerializer