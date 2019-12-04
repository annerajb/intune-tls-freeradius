docker stop radius
docker rm radius
docker build . -t radius
docker run --name radius -it --rm -p 1812-1813:1812-1813/udp radius -X
docker exec -it radius sh

#docker logs -f radius
