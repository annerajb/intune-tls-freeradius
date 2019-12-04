docker run -it --rm --link radius:rad chrohrer/eapol_test sh
eapol_test -c mac-tls.conf  -s preshared_key -a radius_ip
