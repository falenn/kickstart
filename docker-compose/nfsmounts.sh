#!//bin/bash


NFS_HOST=192.168.2.10

# create mount
# $1 path
# $2 mountName
function createMount() {
  sudo docker volume create \
    --driver local \
    --opt type=nfs \
    --opt o=addr=$NFS_HOST,rw \
    --opt device=:$1 \
    $2
}


# check mount
# $1 mountName
function checkMount() {
  sudo docker volume list | grep $1 2>&1>/dev/null
  echo $?
}


mount=repository
result=`checkMount $mount`
echo "checking Mount: $result"
if [ $result -eq 1 ]; then 
  echo "creating mount $mount"	
  createMount "/AJB/repository" $mount
else
  echo "Mount $mount exists"
fi

sudo docker volume list

