install:
	pip install --upgrade pip &&\
		pip install --no-cache-dir -r requirements.txt

test:
	python -m pytest -vv --cov=main --cov=mylib test_*.py

format:	
	black *.py 

lint:
	ruff --extend-ignore E501 *.py mylib/*.py

container-lint:
	docker run --rm -i hadolint/hadolint < Dockerfile

refactor: format lint

deploy:
	#deploy goes here
		
all: install lint test format deploy

generate_and_push:
	# Create the markdown file 
	python test_main.py  # Replace with the actual command to generate the markdown

	# Add, commit, and push the generated files to GitHub
	@if [ -n "$$(git status --porcelain)" ]; then \
		git config --local user.email "Sammyissmiling@gmail.com"; \
		git config --local user.name "GitHub Action"; \
		git add .; \
		git commit -m "SQL log"; \
		git push; \
	else \
		echo "No changes to commit. Skipping commit and push."; \
	fi

extract:
	etl_query extract

setup_package: 
	python setup.py develop --user

#PYTHON := /opt/anaconda3/bin/python

transform_load:
#	$(PYTHON) -m pip install -r requirements.txt
#	$(PYTHON) main.py transform_load
	etl_query transform_load

query:
	etl_query general_query "SELECT t1.country, t1.category, t1.category,AVG(t1.Followers) as avg_followers,COUNT(*) as total_Account FROM default.InstagramData t1 JOIN default.InstagramTop1000 t2 ON t1.Account = t2.Account GROUP BY t1.country, t1.category ORDER BY avg_followers DESC LIMIT 10"