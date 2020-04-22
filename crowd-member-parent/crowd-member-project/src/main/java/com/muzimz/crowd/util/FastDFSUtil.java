package com.muzimz.crowd.util;

import com.muzimz.crowd.file.FastDFSFile;
import org.csource.common.NameValuePair;
import org.csource.fastdfs.ClientGlobal;
import org.csource.fastdfs.StorageClient;
import org.csource.fastdfs.TrackerClient;
import org.csource.fastdfs.TrackerServer;
import org.springframework.core.io.ClassPathResource;

/**
 * 实现文件上传、文件删除、文件下载、
 * 文件信息获取、storage信息获取、tracker信息获取
 */
public class FastDFSUtil {
    /**
     * 加载tracker连接信息
     */
    static {
        try {
            String file_path = new ClassPathResource("fdfs_client.conf").getPath();
            ClientGlobal.init(file_path);
        }catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * @param fastDFSFile :上传的文件信息封装
     * @return
     */
    public static String upload(FastDFSFile fastDFSFile) throws Exception{
        //附加参数
        NameValuePair[] meta_list = new NameValuePair[1];
        meta_list[0] = new NameValuePair("author", fastDFSFile.getAuthor());

        // 创建一个Tracker访问的客户端对象TrackerClient
        TrackerClient trackerClient = new TrackerClient();
        // 通过TrackerClient访问的TrackerServer服务，获取连接信息
        TrackerServer trackerServer = trackerClient.getConnection();
        // 通过TrackerServer的链接信息可以获取Storage的连接信息，创建StorageClient对象存储Storage的连接信息
        StorageClient storageClient = new StorageClient(trackerServer, null);
        /**
         * 通过StorageClient访问Storage，实现文件上传，并且获取文件上传后的存储信息
         * 1. 上传文件的字节数组
         * 2. 文件的扩展名 jpg
         * 3. 附加参数 比如：拍摄地点
         * uploads[]
         *      uploads[0]: 文件上传所存储的Storage的组名字 group1
         *      uploads[1]: 文件存储到Storage上的文件名字 M00/02/44/muzi.jpg
         */
        String[] uploads = storageClient.upload_file(fastDFSFile.getContent(), fastDFSFile.getExt(), meta_list);
        return "http://115.29.149.30:8080/" + uploads[0] + "/" + uploads[1];
    }
}
