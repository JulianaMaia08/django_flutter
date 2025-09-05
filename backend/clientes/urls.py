from django.urls import path
from .views import ClienteListApi, ClienteDetailApi

urlpatterns = [
    path('clientes/', ClienteListApi.as_view(), name='cliente-list-create'),
    path('clientes/<int:id>/', ClienteDetailApi.as_view(), name='cliente-detail'),
]