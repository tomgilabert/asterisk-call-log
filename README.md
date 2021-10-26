# asterisk-call-log
Search faster calls and show call log in asterisk pbx

Tired of looking for calls in the logs using grep by extension, by time, by callid ...

This script is make it for find calls fast, clear and show colored logs

This bash script is made by a beginner ;), of course it can be improved...

Requires installing "bat" to show colored logs, bat is a cat with wings: https://github.com/sharkdp/bat 

For use it, simply run script.sh extension (example: sh script.sh 1234)

And script will find calls make/receive by this extension in last 24 hours and show this calls in a menu with necessary information then select required call and script will show log of call
