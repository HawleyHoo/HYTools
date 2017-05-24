//
//  ViewController.m
//  HYTools
//
//  Created by 胡杨 on 2017/5/8.
//  Copyright © 2017年 net.fitcome.www. All rights reserved.
//

#import "ViewController.h"

#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self socketTest];
}

- (void)socketTest {
    
    
    /**
     1 创建socket

      domain:  AF_INET 协议域 AF_INET -> IPV4
      type:    socket类型 SOCK_STREAM/SOCK_DGRAM(报文UDP)
      protocol IPPROTO_TCP 如果写0，那么就会自动选择！根据第二个参数。
      socket
     */
    int clientSocket = socket(AF_INET, SOCK_STREAM, 0);
    
    /**
     2. 连接到服务器

      客户端socket
      指向结构体sockaddr的指针，其中包含端口的IP地址
      结构体数据长度
      0成功 / 其他 错误码
     */
    struct sockaddr_in serverAddr;
    serverAddr.sin_port = htons(80);
    serverAddr.sin_addr.s_addr = inet_addr("127.0.0.1");
    int connectResult = connect(clientSocket, (const struct sockaddr *)&serverAddr, sizeof(serverAddr));
    if (connectResult == 0) {
        NSLog(@" 连接成功");
    } else {
        NSLog(@" 连接失败 %d", connectResult);
        
    }
    
    
    /**
     3 发送数据

     客户端socket
     发送内容地址（指针）
     发送内容长度
     发送方式标识，一般为0
     
     void * 万能指针
     
     返回值，如果成功，则返回发送的字节数，失败则返回SOCKET_ERROR
     */
    NSString *msg = @"hello";
    ssize_t sendLength = send(clientSocket, msg.UTF8String, strlen(msg.UTF8String), 0);
    NSLog(@" 发送了 %ld 字节", sendLength);
    
    
    
    /**
     4. 读取数据

      clientSocket 客户端socket
      buffer 接收数据缓冲区
      buffer 接受收据长度
      接受方式，0表示阻塞，必须等待服务器返回数据
     
     return 如果成功，则返回读入的字节数，失败则返回SOCKET_ERROR
     */
    uint8_t buffer[1024];
    ssize_t recvLen = recv(clientSocket, buffer, sizeof(buffer), 0);
    NSLog(@" 接收到了 %ld 字节", recvLen);
    
    // 5 关闭连接
    close(clientSocket);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
