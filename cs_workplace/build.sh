#!/bin/bash 


## USER ID and GID when run the command
RUN_USER_UID=$(id $USER -g)
RUN_USER_GID=$(id $USER -g)

DOCKER_USER_NAME=${DOCKER_USER_NAME:-$USER}
DOCKER_USER_GROUP=${DOCKER_USER_GROUP:-$(groups|awk '{print $1}')}
DOCKER_USER_GID=${DOCKER_USER_GID:-${RUN_USER_UID}}
DOCKER_USER_UID=${DOCKER_USER_UID:-${RUN_USER_GID}}
# components
DOKCER_FROM="FROM python:3.6"
DOCKER_RUN="RUN apk --no-cache add \\"
DOCKER_ENV='ENV'
DOCKER_ARG='ARG'
DOCKER_RUN_CLEAN="&&apt del \\"
DOCKER_RUN_ADD_USER="  &&addgroup -g ${DOCKER_USER_GID} ${DOCKER_USER_GROUP} && adduser -D -G ${DOCKER_USER_GROUP} -u ${DOCKER_USER_UID} -h /home/${DOCKER_USER_NAME} ${DOCKER_USER_NAME} && mkdir -p /home/${DOCKER_USER_NAME}/work_dir&& chown ${DOCKER_USER_NAME}:${DOCKER_USER_GROUP} -R /home/${DOCKER_USER_NAME}/work_dir"
DOCKER_FILE="Dockerfile"
DOCKER_FILE_LIST="
/disk/work/docker/awscli/Dockerfile
/disk/work/docker/packer/Dockerfile
/disk/work/docker/terraform/Dockerfile
/disk/work/docker/ansible/Dockerfile
"
TMP_ADD_APK_FILE="add_apk_file"
TMP_DEL_APK_FILE="del_apk_file"
TMP_ADD_PKG_FILE="other_pkg_file"
TMP_ADD_ARG_FILE="add_ARG_FILE"
TMP_ADD_ENV_FILE="add_ENV_FILE"

find_RUN(){
    local_docker_file=$@

    all_apk_packge=""
    all_other_packge=""
    for each_docker_file in ${local_docker_file}
    do

        apk_line_start_pattern='^RUN[[:space:]]apk'
        pkg_line_pattern='[[:space:]]\+&&'
        last_line_pattern='[[:space:]]\+&&apk[[:space:]]del'
        line_num_pattern='-d : -f1'

        # Argument and environemnts file
        grep ${DOCKER_ARG} ${each_docker_file} >> ${TMP_ADD_ARG_FILE}
        grep ${DOCKER_ENV} ${each_docker_file} >> ${TMP_ADD_ENV_FILE}

        # anything startwith "&&"
        all_steps_line=$(grep -on ${pkg_line_pattern} ${each_docker_file}|cut ${line_num_pattern} )
        first_other_pkg_line=$(grep -on ${pkg_line_pattern} ${each_docker_file}|cut ${line_num_pattern}|head -n 1)
        # anything endwith"&&apk",apk will do cleanup at last
        last_other_pkg_step=$(expr $(grep -on ${last_line_pattern} ${each_docker_file}|cut ${line_num_pattern}) - 1 )
        del_pkg_step=$(expr $(grep -on ${last_line_pattern} ${each_docker_file}|cut ${line_num_pattern}) + 1 )
        after_run_step=$(expr $(grep -n ^[A-Z] ${each_docker_file} |grep -A 1 "RUN"|cut ${line_num_pattern}) - 1 )


        # the line after RUN apk are the run packages to install 
        first_apk_start_line=$(expr $(grep -on ${apk_line_start_pattern} ${each_docker_file}|cut ${line_num_pattern}) + 1)
        # # the fist start with && line will be the 
        last_apk_end_line=$(expr $(grep -on ${pkg_line_pattern} ${each_docker_file}|cut ${line_num_pattern}|head -n 1) - 1)

        add_apk_package_name=$(sed -n ''"${first_apk_start_line}"','"${last_apk_end_line}"'p' $each_docker_file >> ${TMP_ADD_APK_FILE})
        other_package_name=$(sed -n ''"${first_other_pkg_line}"','"${last_other_pkg_step}"'p' $each_docker_file >> ${TMP_ADD_PKG_FILE})
        del_pak_package_name=$(sed -n ''"${del_pkg_step}"','"${after_run_step}"'p' $each_docker_file >> ${TMP_DEL_APK_FILE})
        # all_apk_packge="${all_apk_packge}
        # ${apk_package_name}"
        # all_other_packge="${all_other_packge} ${other_package_name}"
        
    done
    #  ${all_apk_packge} >> Dockerfile
    # sed -i '/RUN apk/a'"$apk_package_name"'' Dockerfile 
    # echo ${apk_package_name}
    # echo ${other_package_name}
}
# remove docker files
[ -f ${DOCKER_FILE} ] && rm ${DOCKER_FILE}
[ -f ${TMP_ADD_APK_FILE} ] && rm ${TMP_ADD_APK_FILE}
[ -f ${TMP_ADD_PKG_FILE} ] && rm ${TMP_ADD_PKG_FILE}
[ -f ${TMP_DEL_APK_FILE} ] && rm ${TMP_DEL_APK_FILE}
[ -f ${TMP_ADD_ARG_FILE} ] && rm ${TMP_ADD_ARG_FILE}
[ -f ${TMP_ADD_ENV_FILE} ] && rm ${TMP_ADD_ENV_FILE}

find_RUN ${DOCKER_FILE_LIST}

# add then together
echo ${DOKCER_FROM} >>${DOCKER_FILE}
cat ${TMP_ADD_ARG_FILE} >>${DOCKER_FILE}
cat ${TMP_ADD_ENV_FILE} >>${DOCKER_FILE}
echo ${DOCKER_RUN} >> ${DOCKER_FILE}
cat ${TMP_ADD_APK_FILE} >> ${DOCKER_FILE}
cat ${TMP_ADD_PKG_FILE} >> ${DOCKER_FILE}
echo "   &&apk del \\" >> ${DOCKER_FILE}
cat ${TMP_DEL_APK_FILE} >> ${DOCKER_FILE}
echo "">> ${DOCKER_FILE}
echo  ${DOCKER_RUN_ADD_USER} >> ${DOCKER_FILE}
docker build --rm --force-rm -t cs-workplace:latest . || exit 1

[ -f ${TMP_ADD_APK_FILE} ] && rm ${TMP_ADD_APK_FILE}
[ -f ${TMP_ADD_PKG_FILE} ] && rm ${TMP_ADD_PKG_FILE}
[ -f ${TMP_DEL_APK_FILE} ] && rm ${TMP_DEL_APK_FILE}
[ -f ${TMP_ADD_ARG_FILE} ] && rm ${TMP_ADD_ARG_FILE}
[ -f ${TMP_ADD_ENV_FILE} ] && rm ${TMP_ADD_ENV_FILE}
