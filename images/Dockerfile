# Container image that runs your code
FROM debian:11.5

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update && apt-get -y install git

RUN useradd -ms /bin/bash test-user

CMD ["/bin/bash"]