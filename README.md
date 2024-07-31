# Prometheus exporter for Nimble SRT


How to use:
 
```shell
      - name: srt-exporter
        image: {{ $.Values.werf.image.exporter }}
        command:
        - /nimble_exporter
        - -auth_salt=590
        - -auth_hash=xxxx
        ports:
        - containerPort: 9017
          name: exporter
          protocol: TCP
        resources:
          {{ toYaml $.Values.resources.exporter |  nindent 10 }}
```