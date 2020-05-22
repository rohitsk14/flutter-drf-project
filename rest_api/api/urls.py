from django.urls import path, include
from .views import *
from rest_framework.routers import DefaultRouter

router = DefaultRouter()
router.register('details', Details, basename='details')

urlpatterns = [
    path('details/', Details, name="details"),
    path('viewset/', include(router.urls)),

]