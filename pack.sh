#!/bin/sh

# 应用名,必须唯一,需修改为实际应用名
appName="myweb"

# jenkins的工作路径,
#为一个路径加上应用名，例如：/var/jenkins/myweb
echo "WORKSPACE=${WORKSPACE}"

# jenkins的temp工作路径,
#为一个路径加上应用名@tmp，例如：/var/jenkins/myweb@tmp
# 该路径不一定存在，因此如果使用需要主动创建
echo "WORKSPACE_TMP=${WORKSPACE_TMP}"

# 生成压缩包的根路径，存放最终生成的${appName}.tar.gz文件
zipPath="${WORKSPACE_TMP}"
# 存放压缩前的文件
appPath="${zipPath}/${appName}"


mkdir -p ${appPath}
rm -rf   ${appPath}/*
rm -rf   ${zipPath}/${appName}.zip

# 编译生成的包路径,注意按照实际情况修改
targetPath="${WORKSPACE}/target"

#####################################
# 将应用编译后生成的文件及依赖文件复制到/data/${appName} 路径下

# 必须包含构建docker镜像的Dockerfile文件
cp ${WORKSPACE}/Dockerfile ${appPath}

# 复制应用编译生成的文件
cp ${targetPath}/myweb.war ${appPath}

#####################################
# 压缩成${appName}.tar.gz
# 注意压缩包需要放到Jenkins的WORKSPACE下，否则ssh publishers插件会找不到文件
rm -rf ${WORKSPACE}/${appName}.tar.gz
tar -czvPf ${WORKSPACE}/${appName}.tar.gz ${appPath}
rm -rf ${zipPath}
