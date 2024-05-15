from rest_framework import routers
from core.views.auth_views import *

router = routers.DefaultRouter()
#--------below is final version
router.register('api', UserViewset)

