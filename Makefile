default:
	$(MAKE) clean
	$(MAKE) deps
	$(MAKE) all
clean:
	-rm -rf build/
	-rm -rf vendor/
	-rm -rf Godeps/_workspace
	-rm -rf tmp/
	-rm -rf profile.cov
deps:
	bash -c "./scripts/deps.sh"
test:
	bash -c "./scripts/test.sh $(TEST_TYPE)"
test-legacy:
	bash -c "./scripts/test.sh legacy"
test-small:
	bash -c "./scripts/test.sh small"
test-medium:
	bash -c "./scripts/test.sh medium"
test-large:
	bash -c "./scripts/test.sh large"
check:
	$(MAKE) test
all:
	bash -c "./scripts/build.sh $(PWD)"
protobuf:
	curl -L -o mesos_pb2.proto https://raw.githubusercontent.com/apache/mesos/0.28.1/include/mesos/mesos.proto
	protoc --go_out=import_path=mesos_pb2:mesos/mesos_pb2 mesos_pb2.proto
	mv mesos/mesos_pb2/mesos_pb2.pb.go mesos/mesos_pb2/mesos_pb2.go
	rm -f mesos_pb2.proto
