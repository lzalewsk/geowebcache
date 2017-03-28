# geowebcache
Geowebcache docker images, meant to be used with configurations.
Work in progress

### To build
Native JAI on tomcat does work.
```docker build --rm -t lzalewsk/geowebcache .```

### To RUN
```docker run --name "geowebcache" -p 8083:8080 -d -t -v $(pwd)/config:/config -v $(pwd)/cache:/cache lzalewsk/geowebcache```
