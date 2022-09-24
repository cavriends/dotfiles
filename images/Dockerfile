# Container image that runs your code
FROM debian:11.5

RUN apt-get install git -y

RUN useradd -ms /bin/bash test-user
USER test-user
WORKDIR /home/test-user

CMD ["/bin/bash"]