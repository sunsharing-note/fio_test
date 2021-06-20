# fio_test

IO读写测试操作步骤
1.     需要在测试机器（操作系统建议为centos 7或ubuntu 18.04或更高版本）上安装fio；
2.     分区并挂载测试盘；
3.     将脚本fio_test.job和fio_test.sh拷贝至同一目录，修改fio_test.sh的四个参数：dir、disk、runtime、size；runtime至少10分钟，推荐30分钟；size至少100G，推荐500G；
4.     运行 nohup ./fio_test.sh &；等待运行结束；
5.     最终的结果保存在当前目录的fio_test_${disk}.out文件。
