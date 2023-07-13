FROM alfg/nginx-rtmp:v1.6.0

# ===== Download overlays (lowerthierds) =====
WORKDIR /usr/local/nginx/scripts/images
COPY img .

RUN for i in {2..20}; do \
		cp ../1.sh ../${i}.sh; \
		cp 1lowerthird.png ${i}lowerthird.png; \
		cp 1video.mp4 ${i}video.mp4; \
		cp 1holding.mp4 ${i}holding.mp4; \
		cp 1failover.mp4 ${1}failover.mp4; \
	done
RUN mkdir lowerthird
RUN cp *lowerthird.png lowerthird
