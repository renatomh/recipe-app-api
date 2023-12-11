# This command will build the Docker image for the local app
build:
	docker-compose build

# This command will build the Docker image for the deploy app
build-deploy:
	docker-compose -f docker-compose-deploy.yml build

# This command initialize the Django app. It's used when first creating the app
init-django:
	docker-compose run --rm app sh -c "django-admin startproject app ."

# This command initialize the core app. It's used when first creating the app
init-core:
	docker-compose run --rm app sh -c "python manage.py startapp core"

# This command initialize the user app. It's used when first creating the app
init-user:
	docker-compose run --rm app sh -c "python manage.py startapp user"

# This command initialize the recipe app. It's used when first creating the app
init-recipe:
	docker-compose run --rm app sh -c "python manage.py startapp recipe"

# This command starts up the local service
start:
	docker-compose up

# This command starts up the deploy service
start-deploy:
	docker-compose -f docker-compose-deploy.yml up

# This command will clear the Docker container for the local app
clear:
	docker-compose down

# This command will clear the Docker container for the deploy app
clear-deploy:
	docker-compose -f docker-compose-deploy.yml down

# This command will lint the app code in the docker container
lint:
	docker-compose run --rm app sh -c "flake8"

# This command is used to test the application
test:
	docker-compose run --rm app sh -c "python manage.py test"

# This command is used to test and lint the application
test-lint:
	docker-compose run --rm app sh -c "python manage.py test && flake8"

# This command is used to create migrations for the app
migrations:
	docker-compose run --rm app sh -c "python manage.py makemigrations"

# This command is used to run migrations on the database
migrateup:
	docker-compose run --rm app sh -c "python manage.py wait_for_db && python manage.py migrate"

# This command is used to create a superuser for the app
superuser:
	docker-compose run --rm app sh -c "python manage.py createsuperuser"

.PHONY: build build-deploy init-django init-core init-user init-recipe start start-deploy clear clear-deploy lint test test-lint migrations migrateup superuser
