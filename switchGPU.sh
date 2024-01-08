#! /bin/bash

driver=$(prime-select query)
echo "currently on $driver GPU"

if [ "$driver" == "intel" ];
then	
	sudo prime-select nvidia
else
	sudo prime-select intel
fi

exit
