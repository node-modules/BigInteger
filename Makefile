TESTS = test/*.test.js
REPORTER = spec
TIMEOUT = 5000
MOCHA_OPTS =

install:
	@npm install

test: install
	@NODE_ENV=test ./node_modules/mocha/bin/mocha \
		--reporter $(REPORTER) \
		--timeout $(TIMEOUT) \
		$(MOCHA_OPTS) \
		$(TESTS)

test-cov cov: install
	@NODE_ENV=test node --harmony \
		node_modules/.bin/istanbul cover --preserve-comments \
		./node_modules/.bin/_mocha \
		-- \
		--reporter $(REPORTER) \
		--timeout $(TIMEOUT) \
		$(MOCHA_OPTS) \
		$(TESTS)
	@./node_modules/.bin/cov coverage

test-travis: install
	@NODE_ENV=test node --harmony \
		node_modules/.bin/istanbul cover --preserve-comments \
		./node_modules/.bin/_mocha \
		--report lcovonly \
		-- \
		--reporter dot \
		--timeout $(TIMEOUT) \
		$(MOCHA_OPTS) \
		$(TESTS)

test-all: install jshint test cov

autod: install
	@./node_modules/.bin/autod -w --prefix "~"
	@$(MAKE) install

contributors: install
	@./node_modules/.bin/contributors -f plain -o AUTHORS

.PHONY: test