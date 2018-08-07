#!/bin/bash


aws_profile="$HOME/.aws/credentials"
profile=${AWS_PROFILE:-default}

profile_line_num=$(grep -n "^\[$profile" $aws_profile|cut -d ":" -f1)
AWS_KEY_NUBMER=$(grep -ni "^AWS_ACCESS_KEY" $aws_profile| cut -d ":" -f1|sort -n)
AWS_SECRET_NUBMER=$(grep -ni "^AWS_SECRET_ACCESS_KEY" $aws_profile| cut -d ":" -f1|sort -n)


if [ -z "${profile_line_num}" ]
then
	echo "Cannot find profile: $profile"
    exit 1
fi
# key an secret should be less than profile

for each_key_num in ${AWS_KEY_NUBMER}
do
    if [ $each_key_num -gt ${profile_line_num} ];then
        profile_key_line_number=$each_key_num
        break
    fi
done

for each_secret_num in ${AWS_SECRET_NUBMER}
do
    if [ $each_secret_num -gt ${profile_line_num} ];then
        profile_secret_line_number=$each_secret_num
        break
    fi
done

if [ -z "${profile_key_line_number}" ];
then
    echo "Cannot find keys"
    exit 1
fi

if [ -z "${profile_secret_line_number}" ];then
    echo "Cannot find your secret"
    exit 1
fi


export $(sed -n ''"${profile_key_line_number}"'p;' ${aws_profile}| sed 's| ||g')
export $(sed -n ''"${profile_secret_line_number}"'p;' ${aws_profile}| sed 's| ||g')
