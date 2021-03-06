# MNetwork
## Description/简介

[MNetwork](https://github.com/MichaelLynx/MNetwork) is an HTTP networking library written in Swift.

This network request library is a secondary package of `Alamofire` and `HandyJSON` library, including the network request class `MNetwork`, the network request resend class `MNetworkParameter`.

This network request library supports the switch between the distribution server and the development server, and supports the network request to be resent after the failure of the network request.

When using it, you need to add the third-party libraries ` Alamofire ` and ` HandyJSON `, and  import the MNetwork folder(MNetwork and MNetWorkParameter) into the project. Then you can use the class `MNetwork` to make network requests. Interface and other data information can be modified in `MNetwork` class.



[MNetwork](https://github.com/MichaelLynx/MNetwork)是一个用swift编写的网络请求库。

本网络请求库是对Alamofire及HandyJSON库的二次封装，包括网络请求的类`MNetwork`、网络请求失败时重新发送使用的保存网络请求信息的类`MNetWorkParameter`。

本网络请求库支持正式服和测试服的切换，支持网络请求失败后重新进行网络请求。

使用时需先导入第三方库`Alamofire`和`HandyJSON`，然后将MNetwork文件夹里的内容（MNetwork文件和MNetWorkParameter文件）导入项目，即可调用`MNetwork`类进行网络请求。接口等数据信息在`MNetwork`类里修改。




## Version/版本更新

### v1.0.0: 2020-04-03

The initial release.

### v1.0.1: 2021-01-18

The version is optimized and can now be imported and used directly without any major changes.

### v1.0.2: 2021-01-28

Simplified the code, removed the redundant files, and now you can import just two files to use the library.

### v1.0.3:2021-01-29

Added an example of replacing parameter keywords with `HandyJSON`. 

