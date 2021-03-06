VERSION = 15

targets = base lint gcc-6 gcc-8 gcc-9 gcc-10 gcc-10-multilib clang-3.8 clang-9 clang-10

all: ${targets}

${targets}: Dockerfile
	docker build -t ethereum/cpp-build-env:${VERSION}-$@ --target=$@ .


define create_push_target

push/${1}: ${1}
	docker push ethereum/cpp-build-env:${VERSION}-${1}

endef

$(foreach t,${targets},$(eval $(call create_push_target,${t})))

push: $(addprefix push/,${targets})
