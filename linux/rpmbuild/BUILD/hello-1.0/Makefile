sayhello:hello.c
	gcc -o $@ $^

install:sayhello
	install -m 755 sayhello ${INSTALL_PATH}/usr/local/bin/sayhello
	install -m 755 sayhello.1 ${INSTALL_PATH}/usr/local/share/man/man1/sayhello.1
clean:
	rm -rf sayhello ${INSTALL_PATH}/usr/local/bin/sayhello ${INSTALL_PATH}/usr/local/share/man/man1/sayhello.1



