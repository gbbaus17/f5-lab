 
The Server has the following avaliable


# Web App firewall testing sites

## DamnSmallVulenerableWeb - Jumphost has installer [.py] pointing to ASM VIP
- docker run -d -p 80:8000 --restart always --name dsvm_f5lab -it gbbaus17/dsvw

## Webgoat
- docker run -d -p 8081:8080 -p 81:80 --restart always --name webgoat_f5lab -it danmx/docker-owasp-webgoat

## DVWA
- docker run -d -p 8082:3306 -p 82:80 --restart always --name dvwa_f5lab -e MYSQL_PASS="f5DEMOs4u!" -it citizenstig/dvwa

## Hackazon
- docker run  -d -p 83:80 --restart always --name hackazon_f5lab -it mutzel/all-in-one-hackazon

## App-Sec https://github.com/ArtiomL/f5-app-sec
- docker run -d -p 443:8443 --restart always --name f5appsec_f5lab -it artioml/f5-app-sec

# Standard Websites for LB Tests
- docker run -d -p 8440:443 -p 8000:80 --restart always --name red_f5lab -e F5DEMO_APP=website -e F5DEMO_COLOR=FF0000 -e F5DEMO_NODENAME='Red' -it f5devcentral/f5-demo-httpd

- docker run -d -p 8441:443 -p 8001:80 --restart always --name green_f5lab -e F5DEMO_APP=website -e F5DEMO_COLOR=33FF33 -e F5DEMO_NODENAME='Green' -it f5devcentral/f5-demo-httpd

- docker run -d -p 8442:443 -p 8002:80 --restart always --name blue_f5lab -e F5DEMO_APP=website -e F5DEMO_COLOR=3333FF -e F5DEMO_NODENAME='Blue' -it f5devcentral/f5-demo-httpd

