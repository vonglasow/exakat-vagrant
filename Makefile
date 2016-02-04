install: clean
	ansible-galaxy install -r .ansible/requirements.yml -p .ansible/vendor

clean:
	rm -rf .ansible/vendor

.PHONY: clean all
