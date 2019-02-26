max="$1"
date
echo "url: $2
rate: $max calls / second"
START=$(date +%s);

get () {
  curl -s -v "$1" 2>&1 | tr '\r\n' '\\n' | awk -v date="$(date +'%r')" '{print $0"\n-----", date}'\
  -X POST \
  -H 'Authorization: Basic Y2xpZW50OnNlY3JldA==' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Postman-Token: 70d4ed9e-7209-4e35-9daf-68cb84730954' \
  -H 'cache-control: no-cache' \
  -d 'username=radimetrics&password=dose_mon&undefined='
}

while true
do
  echo $(($(date +%s) - START)) | awk '{print int($1/60)":"int($1%60)}'
  sleep 1

  for i in `seq 1 $max`
  do
    get $2 &
  done
done
