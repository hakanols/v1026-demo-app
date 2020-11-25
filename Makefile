build:
	docker build -t v1026-demo-app:latest .

run:
	docker run -v ${PWD}:/src -it v1026-demo-app:latest /bin/bash
