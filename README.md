# Make your chromebook a linux developer tool

* Setup linux version:

	https://www.aboutchromebooks.com/news/chrome-os-94-brings-debian-bullseye-to-linux-on-chromebooks/

	chrome://flags#crostini-container-install
	set to Bookworm / Debian 12

* Enable linux:

	Settings / Advanced / Linux / Enable

* Install my favorite tools

	\# mail and name --> .gitconfig <br>
	$ bash setup.sh "*your@mail.address*"   "*Your Name*"

	* Tools installed:
		* network:<pre>wireshark, tcpdump, traceroute, iftop, dnsutils</pre>
		* tools:<pre>lsof, rsync, jq, bc, tilix, pip3, cmake (for pip3), wget, gpg</pre>
		* lang:<pre>nodejs, dotnet 6 sdk</pre>
		* container:<pre>moby-engine(docker), docker-compose</pre>
		* IDE:<pre>vs_code</pre>
		* python3 modules:<pre>elasticsearch, python-dotenv, prison, azure-eventhub, colorama</pre>

	* Tools installed by default (debian 11):
		<pre>bash, curl, g++, gcc, git, make, openssh-client, openssh-server, openssh-sftp-server, openssl, perl, python3, sudo, vim,  more and less :-)</pre>


* Start to work (life's good :-)

```
hockey@penguin:~$ mkdir -p Project
hockey@penguin:~$ cd Project/
hockey@penguin:~/Project$ git clone https://github.com/hakan-carlsson/chromebook.git
Cloning into 'chromebook'...
remote: Enumerating objects: 13, done.
remote: Counting objects: 100% (13/13), done.
remote: Compressing objects: 100% (11/11), done.
Receiving objects: 100% (13/13), done.
Resolving deltas: 100% (3/3), done.
remote: Total 13 (delta 3), reused 9 (delta 2), pack-reused 0
hockey@penguin:~/Project$ code chromebook/
hockey@penguin:~/Project$ 
```

![image](https://user-images.githubusercontent.com/39298129/162566318-89c7d7e1-90eb-4bc7-9ba4-f405dddc749d.png)


# docker images I've used
* GO lang
<pre>
docker run --rm golang go version
go version go1.22.4 linux/arm64
</pre>
* Elasticsearch, dotnet, grafana

