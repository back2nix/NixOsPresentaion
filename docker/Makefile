build/layer:
	nix-build .

load/layer:
	docker load < result

build/image:
	nix-build hello-docker.nix

load/image:
	docker load < result

run/image:
	docker run -t hello-docker:i9rdppgmfpgpfkrmny2jjgjay70klpbf

dive/image:
	dive hello-docker:i9rdppgmfpgpfkrmny2jjgjay70klpbf
