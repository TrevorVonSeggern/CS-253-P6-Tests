#!/bin/bash

echo ""

#Variables
EXE=(bin/PA*)
CHECKER=bin/check
echo ${EXE}
RESULTCODE=0
EXPECTEDCODE=0
LOGRESULT=0


NONE='\e[0m'
RED='\e[0;31m';
GREEN='\e[0;32m';

COMPILE=0
if [ "COMPILE" == "0" ];
then
	#Building the source
	cd ..
	make buildTest
	cd test
	make
fi

#Testing the files
echo ''
echo Testing files:
echo ''

for FILENAME in tests/* ;
do
	FILENAME=${FILENAME%%/}

	if [ "$FILENAME" != "CMakeFiles" ];
	then
		touch $FILENAME/expected_code.txt
		touch $FILENAME/result.txt
		touch $FILENAME/result_code.txt
		touch $FILENAME/log.txt
		touch $FILENAME/parameters.txt

		EXPECTEDCODE=$(cat $FILENAME/expected_code.txt )

		truncate -s 0 $FILENAME/result.txt

		PARAMS=$(cat $FILENAME/parameters.txt)

		cd $FILENAME/;
		../../$EXE $PARAMS &> result.txt

		# result code handling...
		RESULTCODE=$?														#put result code into a variable.
		cd ../../;
		>$FILENAME/result_code.txt 											#clear result
		echo $RESULTCODE >> $FILENAME/result_code.txt 						#echo result code into file.
		RESULT=$(cat $FILENAME/result.txt)

		if [ "$EXPECTEDCODE" != "$RESULTCODE" ]
		then
			echo ''
			echo -e "${RED}Error: The return code of $FILENAME is not the what is expected.${NONE}" 1>&2
			echo -e "${RED}executed - $FILENAME - with return code [$RESULTCODE]${NONE}"

			if [ "$LOGRESULT" != "" ]
			then
				echo -e "${RED}$RESULT${NONE}"
			fi
		else
			if [ -f "$FILENAME/expected.txt" ];
			then
				./$CHECKER $FILENAME/expected.txt $FILENAME/result.txt
				if [ "$?" != "0" ]
				then
					echo ""
					echo -e "${RED}Error: The results of $FILENAME are different from what is expected${NONE}" 1>&2
					#exit 255
				fi
			fi

			echo -e "${GREEN}executed - $FILENAME - with return code [$RESULTCODE]${NONE}"
		fi



		#Delete empty logs
		if [ "$(cat $FILENAME/log.txt)" = "" ]; then
			rm $FILENAME/log.txt
		fi
	fi
done

echo ""
echo "Finished testing."
exit 0
