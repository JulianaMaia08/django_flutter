from django.core.validators import RegexValidator, EmailValidator
from django.db import models


cpf_validator = RegexValidator(
    regex=r'^\d{11}$',
    message="O CPF deve conter exatamente 11 dígitos numéricos."
)

telefone_validator = RegexValidator(
    regex=r'^\d{10,11}$',
    message="O telefone deve ter 10 ou 11 dígitos numéricos (com DDD)."
)


class Cliente(models.Model):
    nome = models.CharField(max_length=100)
    cpf = models.CharField(max_length=11, validators=[cpf_validator])
    email = models.EmailField(validators=[EmailValidator()])
    telefone = models.CharField(max_length=11, validators=[telefone_validator])

    def __str__(self):
        return self.nome
