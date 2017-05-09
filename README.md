# HYTools
一些常用的工具类和宏

1. UIImage+Color.h
  根据给定颜色创建指定大小的图片。
  
2. MacroDefinition.h
  一些常用函数，用内联函数替换了宏，
  ```
  // 向上取整  GetCeil(16.22, 0.1)    => 16.3
static inline float GetCeil(float value, float location) {
    return ceilf(value * (1.0 / location)) / (1.0 / location);
}
  ```
inline和宏之间的区别 
* 内联函数在编译时展开，而宏在预编译时展开
* 在编译的时候，内联函数直接被嵌入到目标代码中去，而宏只是一个简单的文本替换。
* 内联函数可以进行诸如类型安全检查、语句是否正确等编译功能，宏不具有这样的功能。
* 宏不是函数，而inline是函数
* 宏在定义时要小心处理宏参数，一般用括号括起来，否则容易出现二义性。而内联函数不会出现二义性。
* inline可以不展开，宏一定要展开。因为inline指示对编译器来说，只是一个建议，编译器可以选择忽略该建议，不对该函数进行展开。
* 宏定义在形式上类似于一个函数，但在使用它时，仅仅只是做预处理器符号表中的简单替换，因此它不能进行参数有效性的检测，也就不能享受C++编译器严格类型检查的好处，另外它的返回值也不能被强制转换为可转换的合适的类型，这样，它的使用就存在着一系列的隐患和局限性。

但是同时也要慎用内联：
内联是以代码膨胀（复制）为代价，仅仅省去了函数调用的开销，从而提高函数的执行效率。如果执行函数体内代码的时间，相比于函数调用的开销较大，那么效率的收获会很少。另一方面，每一处内联函数的调用都要复制代码，将使程序的总代码量增大，消耗更多的内存空间。以下情况不宜使用内联：
* 如果函数体内的代码比较长，使用内联将导致内存消耗代价较高。
* 如果函数体内出现循环，那么执行函数体内代码的时间要比函数调用的开销大，在内联函数中不允许使用循环语句和switch结果，带有异常接口声明的函数也不能声明为内联函数。
* 类的构造函数和析构函数容易让人误解成使用内联更有效。要当心构造函数和析构函数可能会隐藏一些行为，如“偷偷地”执行了基类或成员对象的构造函数和析构函数。所以不要随便地将构造函数和析构函数的定义体放在类声明中。
 
3. HYResourcePath.h
  获取沙盒路径
 ```
 NSString *GetDocumentPathWithFile(NSString *file);
NSString *GetCachePathWithFile(NSString *file);
NSString *GetTempPathWithFile(NSString *file);
 ```
         
