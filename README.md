# Make your chromebook a linux developer tool

* Setup linux version:

	https://www.aboutchromebooks.com/news/chrome-os-94-brings-debian-bullseye-to-linux-on-chromebooks/

	chrome://flags#crostini-container-install
	set to Bullseye / Debian 11

* Enable linux:

	Settings / Advanced / Linux / Enable

* Install my favorite tools

	bash setup.sh "your@mail.address" "Your Name"	# mail and name --> .gitconfig
	
* Start to work (life's good :-)

```
hockey@penguin:~$ mkdir -p Project
hockey@penguin:~$ cd Project/
hockey@penguin:~/Project$ git clone git@github.com:hakan-carlsson/chromebook.git
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


