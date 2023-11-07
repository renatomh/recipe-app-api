# This command will build the Docker image for the app
build:
	docker-compose build

# This command initialize the Django app. It's used when first creating the app
init-django:
	docker-compose run --rm app sh -c "django-admin startproject app ."

# This command starts up the service
start:
	docker-compose up

# This command will lint the app code in the docker container
lint:
	docker-compose run --rm app sh -c "flake8"

# This command is used to test the application
test:
	docker-compose run --rm app sh -c "python manage.py test"

.PHONY: build init-django start lint test
