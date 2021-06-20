#! /bin/bash

#测试文件所在目录
dir=/data
#测试的盘符
disk=vdb
#运行时间
runtime=600
#测试文件大小
size=100G


section_list=`cat fio_test.job |grep '\['|grep -v 'global'|sed 's/[],\[]//g'`
cat /sys/block/${disk}/queue/nr_requests > /tmp/${disk}_nr_requests
cat /sys/block/${disk}/queue/max_sectors_kb > /tmp/${disk}_max_sectors_kb

echo 512 > /sys/block/${disk}/queue/nr_requests
echo 2048 > /sys/block/${disk}/queue/max_sectors_kb
echo '' > fio_test_${disk}.out

for section in ${section_list}
do
fio --output=fio_test_${disk}_${section}.out --runtime=${runtime} --size=${size} --directory=${dir} --section=${section} --filename_format='$jobname' fio_test.job
cat fio_test_${disk}_${section}.out >> fio_test_${disk}.out
echo -e '\n\n' >> fio_test_${disk}.out
rm -rf ${dir}/${section}
done

cat /tmp/${disk}_nr_requests > /sys/block/${disk}/queue/nr_requests
cat /tmp/${disk}_max_sectors_kb > /sys/block/${disk}/queue/max_sectors_kb
