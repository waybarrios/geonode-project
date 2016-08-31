up:
	# bring up the services
	docker-compose up -d

build:
	docker-compose build django
	docker-compose build celery

sync:
	# set up the database tablea
	docker-compose  exec django django-admin.py makemigrations --noinput
	docker-compose  exec django django-admin.py migrate account --noinput
	docker-compose  exec django django-admin.py migrate layers --noinput
	docker-compose  exec django django-admin.py migrate geonode_qgis_server --noinput
	docker-compose  exec django django-admin.py migrate --noinput
	docker-compose  exec django django-admin.py loaddata sample_admin


wait:
	sleep 5

logs:
	docker-compose logs --follow

down:
	docker-compose down

test:
	docker-compose run django python manage.py test --failfast

reset: down up wait sync

hardreset: pull build reset
