Godot docker
---

Uma imagem docker que contém a [Godot Engine](https://godotengine.org/)
para utilização em ambiente de CI/CD.

## Customizando sua build

O comando abaixo cria uma imagem `nomedasuaimagem` com a versão 4.3-stable
da Godot Engine e copia apenas os templates de exportação para Web.

```
docker build \
  --build-arg GODOT_VERSION=4.3-stable \
  --build-arg EXPORT_TEMPLATES_GLOB=web* \
  -t nomedasuaimagem .
```

## Utilização

```
docker run --rm -it -v $(pwd):/app -w /app nawarian/godot:4.3-stable
```

## Licença

O projeto está disponibilizado sob licença **CC-BY-SA 4.0**.

Você pode utilizar o projeto, fazer modificações e distribuir
para fins pessoais, de pesquisa e comerciais. É obrigatório
distribuir sob a mesma licença (CC-BY-SA 4.0) e atribuir
créditos ao autor: **Núcleo de Tecnologia do MTST**.

* [Full contents in LICENSE](LICENSE)

