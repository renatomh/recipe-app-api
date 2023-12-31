<h1 align="center"><img alt="Recipe App API" title="Recipe App API" src=".github/logo.png" width="250" /></h1>

# Recipe App API

## 💡 Project's Idea

This project was developed to create an online recipe application.

## 🔍 Features

* Register a new account and login to it;
* Create, view, update and delete recipes;
* Create, view, update and delete recipe tags;
* Create, view, update and delete recipe ingredients;
* Add images to the recipes;
* Filtering by tags and ingredients;

## 🛠 Technologies

During the development of this project, the following techologies were used:

- [Python](https://www.python.org/)
- [Django](https://www.djangoproject.com/)
- [Django REST framework](https://www.django-rest-framework.org/)
- [Docker](https://www.docker.com/)
- [Flake8](https://flake8.pycqa.org/en/latest/)
- [GitHub Actions (CI/CD)](https://github.com/features/actions)
- [Terraform](https://www.terraform.io/)

## 💻 Project Configuration

first, create a *.env* file based on the [*.env.sample*](./.env.sample) template provided.

You should ensure that you have Docker installed on you computer. Once the verification is done, you can use the command below to create the docker image:

```bash
$ docker-compose build
```

## ⏯️ Running

To run the project in a development environment, execute the following command on the root directory.

```bash
$ docker-compose up
```

You can access Django Admin at: http://localhost:8000/admin

You can access the Swagger documentation at: http://localhost:8000/api/docs

Finally, a [Makefile](./Makefile) was created in order to help providing some of the commands listed above in a simple way.

## 🏗️ Infrastructure as Code (IaC) with Terraform

To make it easier to provision infrastructure on cloud providers, you can make use of the [Terraform template](main.tf) provided.

First, you'll need to [install Terraform](https://developer.hashicorp.com/terraform/downloads) on your machine; then, since we're using AWS for the specified resources, you'll need to install the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) as well.

After that, you must set up an IAM user with permissions to manage resources, create an access key for the new user and configure the AWS CLI with the following command (entering the access key ID, secret access key, default region and outout format):

```bash
$ aws configure
```

Once these steps are done, you can use the Terraform commands to create, update and delete resources.

```bash
$ terraform init # Downloads the necessary provider plugins and set up the working directory
$ terraform plan # Creates the execution plan for the resources
$ terraform apply # Executes the actions proposed in a Terraform plan
$ terraform destroy # Destroys all remote objects managed by a particular Terraform configuration
```

If you want to provide the required variables for Terraform automatically when executing the script, you can create a file called *prod.auto.tfvars* file on the root directory, with all needed variables, according to the sample provided ([auto.tfvars](auto.tfvars)).

### Documentation:
* [Overview of best practices for writing Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
* [Codechecker](https://codechecker.app/checker/londonappdev/start/recipe-app-api-2/)
* [GitHub Actions - Marketplace](https://github.com/marketplace?type=actions)
* [GitHub Actions - Docker Login](https://github.com/marketplace/actions/docker-login)
* [GitHub Actions - Checkout](https://github.com/marketplace/actions/checkout)
* [psycopg2 dependencies](https://www.psycopg.org/docs/install.html#build-prerequisites)
* [Writing custom django-admin commands](https://docs.djangoproject.com/en/3.2/howto/custom-management-commands/)
* [unittest.mock.Mock.side_effect](https://docs.python.org/3/library/unittest.mock.html#unittest.mock.Mock.side_effect)
* [django.test.SimpleTestCase](https://docs.djangoproject.com/en/3.2/topics/testing/tools/#django.test.SimpleTestCase)
* [django.contrib.auth.get_user_model](https://docs.djangoproject.com/en/3.2/topics/auth/customizing/#django.contrib.auth.get_user_model)
* [django.contrib.auth.models.AbstractBaseUser.check_password](https://docs.djangoproject.com/en/3.2/topics/auth/customizing/#django.contrib.auth.models.AbstractBaseUser.check_password)
* [auth-user-model](https://docs.djangoproject.com/en/3.2/ref/settings/#auth-user-model)
* [Django Admin | Reversing admin URLs](https://docs.djangoproject.com/en/3.1/ref/contrib/admin/#reversing-admin-urls)
* [Django test client](https://docs.djangoproject.com/en/3.2/topics/testing/tools/#overview-and-a-quick-example)
* [drf-spectacular](https://drf-spectacular.readthedocs.io/en/latest/index.html)
* [drf-spectacular | URL Configuration](https://drf-spectacular.readthedocs.io/en/latest/readme.html#take-it-for-a-spin)
* [Django REST framework | get_serializer_class(self)](https://www.django-rest-framework.org/api-guide/generic-views/#get_serializer_classself)
* [Python getattr()](https://docs.python.org/3/library/functions.html#getattr)
* [Django REST framework | Save and deletion hooks](https://www.django-rest-framework.org/api-guide/generic-views/#get_serializer_classself)
* [DRF Writeable nested relationships](https://www.django-rest-framework.org/api-guide/relations/#writable-nested-serializers)
* [DRF create() and update() methods](https://www.django-rest-framework.org/api-guide/serializers/#saving-instances)
* [Django | Managing static files](https://docs.djangoproject.com/en/3.2/howto/static-files/)
* [NamedTemporaryFile](https://docs.python.org/3/library/tempfile.html#tempfile.NamedTemporaryFile)
* [drf-spectacular | FileField](https://drf-spectacular.readthedocs.io/en/latest/faq.html#filefield-imagefield-is-not-handled-properly-in-the-schema)
* [drf-spectacular | Workflow & schema customization](https://drf-spectacular.readthedocs.io/en/latest/customization.html)
* [The 4 best ways to deploy a Django application](https://youtu.be/IoxHUrbiqUo)
* [uWSGI nginx params file](https://uwsgi-docs.readthedocs.io/en/latest/Nginx.html#what-is-the-uwsgi-params-file)
* [Docker Hub: nginxinc/nginx-unprivileged](https://hub.docker.com/r/nginxinc/nginx-unprivileged)
* [Docker | Environment variables in Compose](https://docs.docker.com/compose/environment-variables/)
* [Chocolatey](https://chocolatey.org/)
* [Notes: Creating SSH Deploy Key](https://github.com/LondonAppDeveloper/build-a-backend-rest-api-with-python-django-advanced-resources/blob/main/deployment.md#deployment)
* [Notes: Install and Configure Dependencies](https://github.com/LondonAppDeveloper/build-a-backend-rest-api-with-python-django-advanced-resources/blob/main/deployment.md#install-and-configure-depdencies)
* [Notes: Managing Service](https://github.com/LondonAppDeveloper/build-a-backend-rest-api-with-python-django-advanced-resources/blob/main/deployment.md#running-docker-service)
* [Install Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/)

## 📄 License

This project is under the **MIT** license. For more information, access [LICENSE](./LICENSE).
