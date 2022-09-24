# Container image that runs your code
FROM debian:11.5

RUN useradd -ms /bin/bash test-user
USER newuser
WORKDIR /home/newuser

CMD ["/bin/bash"]