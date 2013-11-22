run:
	./manage.py run

clean:
	find . -name "*.pyc" | xargs rm -f

tidy:
	rm -rf src var lib bin man include
