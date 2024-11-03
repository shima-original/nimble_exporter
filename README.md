# Prometheus exporter for Nimble SRT

Nimble Exporter is a Prometheus exporter to server application that processes and reports metrics related to Secure Reliable Transport (SRT) senders.

## How to use

To build app in Docker container, execute a command

```
docker build . --rm -t nimble_exporter:alpha  
```
 
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

## Nimble Exporter documentation generation

### Prerequisites: git, python, mkdocs all installed

Step 1:
Install git
Windows: https://github.com/git-for-windows/git/releases/download/v2.42.0.windows.2/Git-2.42.0.2-64-bit.exe
Linux: apt-get install git
Mac: https://sourceforge.net/projects/git-osx-installer/files/git-2.33.0-intel-universal-mavericks.dmg/download

create a directory for your project eg: c:\www
Open a command prompt in administrator mode.
Change to that new directory.
Git clone the project.
You should receive a popup from github where you enter your token.
The system will now download the api from github

Step 2:
Install Python 3.11 via microsoft store
add python path to your system environment PATH variables: C:\Users\user4k\AppData\Local\Packages\PythonSoftwareFoundation.Python.3.11_qbz5n2kfra8p0\LocalCache\local-packages\Python311\Scripts'

Step 3:
install mkdocs and it's extensions
```
pip install -r requirements.txt
```

### Configuration

There are two parameters in the mkdocs.yml file that you need to take notice of when generating the site files.
base_url and site_url
These options should be set to the URL that you will see in your browser when viewing the site.
They ae needed to be set because some urls need to have absolute urls set eg:images

### Generating the documentation

To generate the documentation, you need to execute the command
```
mkdocs build
```
You will find the generated site located in the site folder.

However if you just want to preview it in realtime, then you execute the command
```
mkdocs serve
```