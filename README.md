This is a Dockerfile that starts a freeradius server configured for doing EAP-TLS with the provided certificates.
TODO: test if we can remove the private key of the CA and this still works. 
   This will require to generate the CSR by hand instead of using make  
REMEMBER TO REPLACE ALL CERTIFICATES UNDER THE raddb/certs folder with your real certificates
1. Download your CA private key to the raddb/certs folder and fill out all the empty files 
2. Run the make server script inside the raddb/certs folder inside the live container 
s will generate your server private and public key on the correct formats. (UNtested import a server cert coming from the same CA)
3. export the generated server private keys to the raddb/certs/ folder (this is the cert that your clients will receive when they try connecting to your wpa-enterprise wifi
4. Generate a client certificate for testing inside the raddb/certs/ folder running make client inside the running container for temporary testing.  remember to read every line of the make file for errors
5. use intune to make the device generate a private key using SCEP or similar from the same Root CA that you copied the private key to the freeradius server and use that on eapol_test client



modify raddb/clients.cnf to allow your radius client/unifi access points / docker access to the server

when creating the intune wifi profile make sure to put the server.cnf commonName SCEPman-Device-Root-CA-V1 
This will prevent a popup to show up asking the user to verify that he is conencting to the correct server. 
First for testing disable ocsp_checking on the mods-enabled/eap file after you get basic certificate working then enable ocsp checking of the certificates.


The test/ folder contains test eapol_test scripts to test out different	aspect of the tls process
Running the start-docker.sh container and reading every line every time you make a request will help you find out the majority of the issues since they mostly will be obvious.

When using the sample test configuration files under test/* first comment out the line related to the ca_certificate and uncomment it back once you got the tls login process working to make sure it works when the client is validating the cvertificate authority

The most obscure issues are related to missing or having a certficiate or key in the wront format in the raddb/certs/ directory.

There is a example under mods-config/*/authorize on how to setup vlan to the TLS clients.

Note that the username that intune asigns to the wifi profiles is added in that file and AFAIK cannot be changed.


