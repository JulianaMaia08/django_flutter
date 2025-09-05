from django.test import TestCase
from rest_framework.test import APITestCase
from rest_framework import status
from django.urls import reverse
from clientes.models import Cliente


class ClienteAPITestCase(APITestCase):
    def setUp(self):
        self.url = reverse('cliente-list-create')
        self.data = {
            "nome": "Juliana Maia",
            "cpf": "12345678901",
            "email": "juliana@example.com",
            "telefone": "11987654321"
        }
        self.cliente = Cliente.objects.create(**self.data)

    def test_listar_clientes(self):
        response = self.client.get(self.url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertGreaterEqual(len(response.data), 1)

    def test_criar_cliente(self):
        novo = {
            "nome": "João Silva",
            "cpf": "98765432100",
            "email": "joao@example.com",
            "telefone": "21912345678"
        }
        response = self.client.post(self.url, novo, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(response.data["nome"], "João Silva")

    def test_detalhe_cliente(self):
        url = reverse('cliente-detail', kwargs={'id': self.cliente.id})
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data["cpf"], self.cliente.cpf)

    def test_atualizar_cliente(self):
        url = reverse('cliente-detail', kwargs={'id': self.cliente.id})
        update_data = {
            "nome": "Juliana Atualizada",
            "cpf": "12345678901",
            "email": "juliana@update.com",
            "telefone": "11987654321"
        }
        response = self.client.put(url, update_data, format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data["nome"], "Juliana Atualizada")

    def test_deletar_cliente(self):
        url = reverse('cliente-detail', kwargs={'id': self.cliente.id})
        response = self.client.delete(url)
        self.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)
        self.assertFalse(Cliente.objects.filter(id=self.cliente.id).exists())
