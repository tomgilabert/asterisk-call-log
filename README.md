# asterisk-call-log
Search calls faster and show call log in asterisk pbx

Tired of looking for calls in the logs using grep by extension, by time, by callid ...

This script is make it for find calls fast, clear and show colored logs

This bash script is made by a beginner ;), of course it can be improved...

Requires installing "bat" to show colored logs, bat is a cat with wings: https://github.com/sharkdp/bat 

For use it, simply run script.sh extension (example: sh script.sh 1234)

And script will find calls make/receive by this extension in last 24 hours and show this calls in a menu with necessary information then select required call and script will show log of call

Menu for select call:
![imagen](https://user-images.githubusercontent.com/9198441/138847916-9da37c1f-a13f-4206-a229-c7040b7bc8cd.png)


Colored log of call selected:
![imagen](https://user-images.githubusercontent.com/9198441/138848606-8ba8b6d9-9070-492d-bb22-5ceebde9b201.png)
