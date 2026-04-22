#  QT项目代码规范谷歌版本
本规范参考[谷歌C++代码规范](https://google.github.io/styleguide/cppguide.html)为蓝本修改了，修改参考了[QT代码规范](https://wiki.qt.io/Qt_Coding_Style/zh)以及公司其他规范。

本文档依照项目的实际情况进行必要的修改，以及提炼出经常要注意以及容易被遗忘的内容整理于此。对于本文未提及的内容以谷歌规范为准。

> PS：[谷歌C++代码规范中文版](/assets/others/Google-Cpp_Style_guide-CN.pdf)，**请在阅读本规范之前至少阅读一遍该文档**。<br>
> 具体实现可以多多参考Chromium 项目源码

## 目录

- [目录](#目录)
- [IDE 代码格式配置](#ide-代码格式配置)
  - [Visual studio （2019）配置](#visual-studio-2019配置)
  - [VS Code 配置](#vs-code-配置)
- [头文件](#头文件)
  - [`#define` 的保护\[必须\]](#define-的保护必须)
  - [包含文件的名称及次序\[含必须\]](#包含文件的名称及次序含必须)
  - [其他\[含必须\]](#其他含必须)
- [作用域](#作用域)
- [类](#类)
  - [接口（Interface）](#接口interface)
  - [拷贝构造函数（Copy Constructors）](#拷贝构造函数copy-constructors)
  - [多重继承（Multiple Inheritance）](#多重继承multiple-inheritance)
  - [其他补充类规范](#其他补充类规范)
- [命名\[必须\]](#命名必须)
  - [文件命名（File Names）](#文件命名file-names)
  - [类型命名（Type Names）](#类型命名type-names)
  - [变量命名（Variable Names）](#变量命名variable-names)
  - [常量命名（Constant Names）](#常量命名constant-names)
  - [函数命名（Function Names）](#函数命名function-names)
  - [命名空间（Namespace Names）](#命名空间namespace-names)
  - [枚举命名（Enumerator Names）](#枚举命名enumerator-names)
  - [宏命名（Macro Names）](#宏命名macro-names)
- [注释](#注释)
  - [注释风格（Comment Style）\[必须\]](#注释风格comment-style必须)
  - [文件注释（File Comments）](#文件注释file-comments)
  - [类注释（Class Comments）](#类注释class-comments)
  - [函数注释（Function Comments）](#函数注释function-comments)
  - [变量注释（Variable Comments）](#变量注释variable-comments)
  - [实现注释（Implementation Comments）](#实现注释implementation-comments)
  - [标点、拼写和语法（ Punctuation,Spelling and  Grammar）](#标点拼写和语法-punctuationspelling-and--grammar)
  - [TODO注释（TODO Comments）\[必须\]](#todo注释todo-comments必须)
- [格式](#格式)
  - [行长度（Line Length）\[必须\]](#行长度line-length必须)
  - [非ASCII字符（Non-ASCII Characters）\[必须\]](#非ascii字符non-ascii-characters必须)
  - [空格还是制表位（Spacesvs.Tabs）\[必须\]](#空格还是制表位spacesvstabs必须)
  - [函数声明与定义（Function Declarations and Definitions）](#函数声明与定义function-declarations-and-definitions)
  - [函数调用（Function Calls）](#函数调用function-calls)
  - [条件语句（Conditionals）](#条件语句conditionals)
  - [循环和开关选择语句（Switch Statements）](#循环和开关选择语句switch-statements)
  - [指针和引用表达式（Pointers and Reference）](#指针和引用表达式pointers-and-reference)
  - [布尔表达式（Boolean Expressions）](#布尔表达式boolean-expressions)
  - [类格式（Class Format）](#类格式class-format)
  - [初始化列表（Initializer Lists）](#初始化列表initializer-lists)
  - [其他补充格式](#其他补充格式)
- [其他补充规范](#其他补充规范)

## IDE 代码格式配置
### Visual studio （2019）配置
通过打开项目选项（Tools>Options）可以选择默认的代码格式，具体见下图<br>
![VS_code_style_cfg](/assets/imgs/posts/2020-08-01-QT-Google-cpp-style-guide-CN/IDE_VS-code_style_cfg.png)

> PS: 本项目选择 **Chromium** 代码格式，直观看可以选择 **Google** ，初步估计应该区别不大。

使用快捷键 `Ctrl+K`, `Ctrl+D` 即可进行代码的自动格式化。

### VS Code 配置
首先安装VS Code 插件 `C/C++ for Visual Studio Code`:<br>
![VS_Code-code_style_extension](/assets/imgs/posts/2020-08-01-QT-Google-cpp-style-guide-CN/IDE_VS_Code-code_style_extension.png)

然后修改配置插件的配置:<br>
![VS_Code-code_style_cfg](/assets/imgs/posts/2020-08-01-QT-Google-cpp-style-guide-CN/IDE_VS_Code-code_style_cfg.png)<br>
也可以直接打开配置json文件添加下面一项内容：<br>
```json
"C_Cpp.clang_format_fallbackStyle": "Chromium"
```

## 头文件
C++的源文件采用 `.cpp` 的后缀，头文件为 `.h`.

### `#define` 的保护[必须]

所有头文件都应该使用`#define`防止头文件被多重包含（multipleinclusion），命名格式当是：`<PATH>_<FILE>_H_` （以下划线结尾）为保证唯一性，头文件的命名应基于其所在项目源代码树的全路径。例如，项目foo中的头文件foo/src/bar/baz.h

按如下方式保护：
```c++
#ifndef BAR_BAZ_H_
#define BAR_BAZ_H_
...
#endif //BAR_BAZ_H_
```

### 包含文件的名称及次序[含必须]

引用项目内的非第三方库头文件，其名称一律采用**从src开始的相对路径**，不得使用当前路径以及其他的路径。其中.ui文件在designer中添加的头文件也必须遵循该规范。[必须]

> PS: 与此同时需要在IDE中把**src路径添加的头文件扫描路径**中。

将包含次序标准化可增强可读性、避免*隐藏依赖（hidden dependencies，译者注：隐藏依赖主要是指包含的文件中编译时）*，**次序如下：<优先位置>、C库、C++库、其他库的.h、项目内的.h**。 优先位置一般为该源文件对应的头文件，即**有着直接的关联性**，例如：<br>
`dir/foo.cc`的主要作用是执行或测试`dir/foo.h`的功能，`foo.cc`中包含头文件的次序如下：
```c++
// 优先位置
#include "dir/foo.h"

// C系统文件
#include<sys/types.h>
#include<unistd.h>

// C++系统文件
#include<hash_map>
#include<vector>

// 其他库头文件
#include "nim_service/module/login/login_manager.h"

// 本项目内头文件
#include"base/basictypes.h"
#include"base/commandlineflags.h"
...
```

### 其他[含必须]

1. 头文件依赖：使用前置声明（forward declarations）尽量减少`.h` 文件中 `#include` 的数量.
2. 内联函数: 只有当函数只有**10行**甚至更少时才会将其定义为内联函数（inline function）。
3. 函数参数顺序（Function Parameter Ordering）: 定义函数时，参数顺序为：**输入参数在前，输出参数在后**。
4. 对于暴露给其他模块的接口的头文件，其**所依赖的头文件不可缺失**（**特别是QT的一些类的头文件**），否则会导致别人引用时编译失败的情况。[必须]

## 作用域

1. `.cpp`中的不具名命名空间可避免命名冲突、限定作用域，避免直接使用`using`提示符污染命名空间， **不能**在`.h`文件中使用不具名命名空间；
2. 嵌套类符合局部使用原则，只是不能在其他头文件中前置声明，尽量不要`public`；
3. 尽量不用全局函数和全局变量，考虑作用域和命名空间限制，尽量单独形成编译单元；
4. 多线程中的全局变量（含静态成员变量）不要使用`class`类型（含STL容器），避免不明确行为导致的bugs。
5. 使用命名空间中的非成员函数或静态成员函数，尽量**不要使用全局函数**。
   
> PS: 作用域的使用，除了考虑名称污染、可读性之外，主要是为降低耦合度，提高编译、执行效率。

## 类

### 接口（Interface）
接口是指满足特定条件的类，这些类以Interface为后缀（非必需）。

定义：当一个类满足以下要求时，称之为纯接口：
1. 只有纯虚函数（"=0"）和静态函数（下文提到的析构函数除外）；
2. 没有非静态数据成员；
3. 没有定义任何构造函数。如果有，也不含参数，并且为protected；
4. 如果是子类，也只能继承满足上述条件并以Interface为后缀的类。

只有在满足上述需要时，类才以Interface结尾，但反过来，满足上述需要的类未必一定以Interface结尾。

### 拷贝构造函数（Copy Constructors）
仅在代码中需要拷贝一个类对象的时候使用拷贝构造函数；不需要拷贝时应使用 `Q_DISABLE_COPY(MyClass)` (QT 自带的不可复制宏)。

### 多重继承（Multiple Inheritance）
真正需要用到多重实现继承（multiple implementation inheritance）的时候非常少，只有当最多一个基类中含有实现，其他基类都是以Interface为后缀的纯接口类时才会使用多重继承。

只有当所有超类（superclass）除第一个外都是纯接口时才能使用多重继承。为确保它们是纯接口，这些类必须以Interface为后缀。

### 其他补充类规范
1. 如果对象需要有意义的（`non-trivial`）初始化，考虑使用另外的`Init()方`法并（或）增加一个成员标记用于指示对象是否已经初始化成功
2. 如果你定义的类继承现有类，而你又没有增加新的成员变量，则不需要为新类定义默认构造函数
3. 所有**单参数构造函数**必须是明确的。在类定义中，将关键字`explicit`加到单参数构造函数前：`explicit Foo(string name)`.
4. 仅当只有数据时使用struct，其它一概使用class
5. 使用组合（composition）通常比使用继承更适宜，如果使用继承的话，只使用公共继承
6. 除少数特定环境外，不要重载操作符
7. 将数据成员私有化，并提供相关存取函数
8. 声明次序（Declaration Order）: `public:`、`protected:`、`private:`，如果那一块没有，直接忽略即可
9. 函数体尽量短小、紧凑，功能单一

## 命名[必须]
命名规则具有一定随意性，但相比按个人喜好命名，一致性更重要，所以不管你怎么想，规则总归是规则。

函数命名、变量命名、文件命名应具有描述性，不要过度缩写，类型和变量应该是名词，函数名可以用“命令性”动词。

尽可能给出描述性名称，不要节约空间，让别人很快理解你的代码更重要.

总结：
1. 宏、枚举等使用全部大写+下划线
2. 变量（含类、结构体成员变量）、文件、命名空间、存取函数等使用全部小写+下划线
3. 类成员变量以下划线结尾
4. 全局变量以g_开头
5. 普通函数、类型（含类与结构体、枚举类型）使用大小写混合，不含下划线
6. 常量(小写k打头)，而后使用大小写混合，不含下划线
7. 参考现有或相近命名约定

### 文件命名（File Names）
文件名要全部小写，每个单词用下划线（_）分隔。如：`my_useful_class.cpp`

**文件命名尽量精简，如非不可避免尽量保证不会于其路径文件夹名重复**

### 类型命名（Type Names）
类型命名每个单词以大写字母开头，不包含下划线：MyExcitingClass、MyExcitingEnum。

所有类型命名——**类、结构体、类型定义（typedef）、枚举——使用相同约定**，例如：
```c++
//classes and structs 
class UrlTable{...
class UrlTableTester{...
struct UrlTableProperties{...

//typedefs
typedef hash_map<UrlTableProperties*,string>PropertiesMap;

//enums
enum UrlTableErrors{...
```

### 变量命名（Variable Names）
变量名一律小写，单词间以下划线相连，**类的成员变量以下划线结尾**，如

`my_exciting_local_variable`、`my_exciting_member_variable_`

普通变量命名, 如：`string table_name`

类数据成员：

结构体的数据成员可以和普通变量一样，不用像类那样接下划线：
```c++
struct UrlTableProperties{
  string name;
  int num_entries;
}
```

全局变量：以g_标志为前缀以示区分。

### 常量命名（Constant Names）
在名称前加k：kDaysInAWeek

所有编译时常量（无论是局部的、全局的还是类中的）和其他变量保持些许区别，k后接大写字母开头的单词：`const int kDaysInAWeek=7;`


### 函数命名（Function Names）

**普通函数**（regular functions）大小写混合，**存取函数**（accessors and mutators）则要求与变量名匹配：

`myExcitingFunction()`、`myExcitingMethod()`、`my_exciting_member_variable()`、`set_my_exciting_member_variable()`。

**QT 特例函数**：**槽函数**（slot function）需要于响应的控件对象名以及信号名称对应，**信号函数**（signal function）信号名称对应：

`slot_push_button_stateChanged()`、`signal_stateChanged()`

**普通函数**：

函数名以小写字母开头，除第一单词，每个单词首字母大写，没有下划线：<br>
```c++
addTableEntry()
deleteUrl()
```

**存取函数**：

存取函数要与存取的变量名匹配，这里摘录一个拥有实例变量`num_entries_`的类：<br>
```c++
class MyClass{
 public:
    ...
    int num_entries() const { retur nnum_entries_; } // GET
    void set_num_entries(int num_entries){num_entries_ = num_entries;} // SET
  
  private:
    int num_entries_;
};
```

其他短小的内联函数名也可以使用小写字母，例如，在循环中调用这样的函数甚至都不需要缓存其值，小写命名就可以接受。


**槽函数**：

槽函数命名格式为 `slot_<object_name>_<signalName>`，其中 `object_name` 为控件对象名（**采用变量名的命名规则**），`signalName` 为信号名（**采用普通函数的命名规则**）<br>
```c++
class QSignalWidget : public QWidget {
  // ...
  void slot_push_button_stateChanged();
  void slot_http_button_connetServer();
  // ...
```

**信号函数**：

信号函数命名格式为 `signal_<signalName>`，其中 `signalName` 为信号名（**采用普通函数的命名规则**）<br>
```c++
class QSignalWidget : public QWidget {
  // ...
  void signal_connetServer();
```

通过以下代码链接信号与槽函数：<br>
```c++
// 链接自定义的信号函数和槽函数
connect(ui_->http_button, // 控件对象名
        &QSignalWidget::signal_connetServer, // 信号函数
        this, 
        &QSignalWidget::slot_http_button_connetServer); // 槽函数
```

### 命名空间（Namespace Names）

命名空间的名称是全小写的，其命名基于目录结构及代码功能：chat_net。

### 枚举命名（Enumerator Names）

枚举值应全部大写，单词间以下划线相连：MY_EXCITING_ENUM_VALUE。

枚举名称属于类型，因此大小写混合：UrlTableErrors。
```c++
enum UrlTableErrors{
  OK=0,
  ERROR_OUT_OF_MEMORY,
  ERROR_MALFORMED_INPUT,
};
```

### 宏命名（Macro Names）

使用宏时要谨慎，尽量以内联函数、枚举和常量代替之。

通常是不使用宏的，如果绝对要用，其命名像枚举命名一样全部大写、使用下划线：
```c++
#define ROUND(x)...
#define PI_ROUNDED 3.0
```

## 注释
注释虽然写起来很痛苦，但对保证代码可读性至为重要，下面的规则描述了应该注释什么、注释在哪儿。当然也要记住，注释的确很重要，但最好的代码本身就是文档（**self-documenting**），类型和变量命名意义明确要比通过注释解释模糊的命名好得多。

基于跨平台的需求以及QT生成工具的缺陷导致的乱码问题，本项目的**所有注释采用英文**，并且**代码文件中尽量不要出现中文**。

**注释是为别人（下一个需要理解你的代码的人）而写的，认真点吧，那下一个人可能就是你！**


### 注释风格（Comment Style）[必须]

统一使用行注释`//`来注释，**不使用**`/**/`。

### 文件注释（File Comments）

在每一个文件开头加入版权公告和作者信息，然后是文件内容描述。

**版权公告和作者信息**：
  - 版权（copyright statement）：Copyright (C) 2020 The STL Company.
  - 许可版本（license boilerplate）：LGPL and GPL.
  - 作者（author line）：标识文件的原始作者及创建日期。<br>如果你对其他人创建的文件做了**重大修改**，将你的信息及修改日期添加到作者信息里，这样当其他人对该文件有疑问时可以知道该联系谁。

**文件内容**：
  每一个文件版权许可及作者信息后，都要对文件内容进行注释说明。

  通常，
  - `.h` 文件要对所声明的类的功能和用法作简单说明，具体的话可以添加**简明示例代码**到注释中。
  - `.cpp` 文件包含了更多的实现细节或算法讨论，如果你感觉这些实现细节或算法讨论对于阅读有帮助，可以把`.cpp`中的注释放到`.h`中，并在`.cpp`中指出文档在.h中。
  
  不要单纯在.h和.cpp间复制注释，复制的注释偏离了实际意义。

例如：<br>
```c++
// Copyright (C) 2020 The STL Company. All rights reserved.
// Use of this source code is governed by a GNU General Public License(GPL) 
// and a GNU Lesser General Public License (LGPL).

// Created: 2020.10.06 @ LT
// Modified: 2020.11.06 @ ltl

// Provides the definition of API_AVAILABLE while we're on an SDK that doesn't
// contain it yet.
```

### 类注释（Class Comments）

每个类的定义要附着描述类的功能和用法的注释，可以添加**简明示例代码**到注释中。
```c++
// Iterates over the contents of a GargantuanTable. Sample usage:
//
//     GargantuanTable_Iterator *iter = table->NewIterator();
//     for(iter->Seek("foo");!iter->done();iter->Next()){
//        process(iter->key(),iter->value());
//     }
//     delete iter;

class GargantuanTable_Iterator{
  ...
};
```

### 函数注释（Function Comments）

函数**声明处注释描述函数功能**，**定义处描述函数实现**。

**函数声明**：

注释于声明之前，描述函数功能及用法，注释使用描述式（"Opens the file"）而非指令式（"Open the file"）；注释只是为了描述函数而不是告诉函数做什么。通常，注释不会描述函数如何实现，那是定义部分的事情。

函数声明处注释的内容：
1. inputs（输入）及outputs（输出），尽量使用变量命名即代码自注释的方式说明参数意义；
2. 对类成员函数而言：函数调用期间对象是否需要保持引用参数，是否会释放这些参数；
3. 如果函数分配了空间，需要由调用者释放；
4. 参数是否可以为NULL；
5. 是否存在函数使用的性能隐忧（performance implications）；
6. 如果函数是可重入的（re-entrant），其同步前提（synchronization assumptions）是什么？


**函数定义**：

每个函数定义时要以注释说明函数功能和实现要点，如使用的漂亮代码、实现的简要步骤、如此实现的理由、为什么前半部分要加锁而后半部分不需要。

不要从.h文件或其他地方的函数声明处直接复制注释，简要说明函数功能是可以的，但重点要放在如何实现上。

### 变量注释（Variable Comments）

通常**变量名本身足以很好说明变量用途**，特定情况下，需要额外注释说明。

**类数据成员**：

每个类数据成员（也叫实例变量或成员变量）应注释说明用途，如果变量可以接受NULL或-1等警戒值（sentinel values），须说明之，如：
```c++
private:
  //Keeps track of the total number of entries in the table.
  //Used to ensure we do not goover the limit. -1 means
  //that we don't yet know how many entries the table has.
  int num_total_entries_;
```

**全局变量（常量）**：和数据成员相似，所有全局变量（常量）也应注释说明含义及用途，如：
```c++
//The total number of tests cases that we run through in this regression test.
const int kNumTestCases = 6;
```

### 实现注释（Implementation Comments）
对于实现代码中巧妙的、晦涩的、有趣的、重要的地方加以注释。

注意**永远不要用自然语言翻译代码作为注释，要假设读你代码的人C++比你强**:D.


### 标点、拼写和语法（ Punctuation,Spelling and  Grammar）
留意标点、拼写和语法，写的好的注释比差的要易读的多。

注释一般是包含适当大写和句点（.）的完整的句子，短一点的注释（如代码行尾的注释）可以随意点，依然要注意风格的一致性。完整的句子可读性更好，也可以说明该注释是完整的而不是一点不成熟的想法。

### TODO注释（TODO Comments）[必须]
对那些临时的、短期的解决方案，或已经够好但并不完美的代码使用TODO注释。

这样的注释要使用全大写的字符串TODO，后面括号（parentheses）里加上你的大名、邮件地址等，还可以加上冒号（colon）：目的是可以根据统一的TODO格式进行查找：

```c++
//TODO(kl@gmail.com):Use a"*"here for concatenation operator.
//TODO(Zeke): change this to use relations.
```

如果加上是为了在“将来某一天做某事”，可以加上一个特定的时间（"Fix by November 2005"）或事件（"Remove this code when all clients can handle XML responses."）。

## 格式
代码风格和格式确实比较随意，但一个项目中所有人遵循同一风格是非常容易的，作为个人未必同意下述格式规则的每一处，但整个项目服从统一的编程风格是很重要的，**这样做才能让所有人在阅读和理解代码时更加容易**。

### 行长度（Line Length）[必须]
每一行代码字符数不超过**80**。 例外：
1. 如果一行注释包含了超过80字符的命令或URL，出于复制粘贴的方便可以超过80字符；
2. 包含长路径的可以超出80列，尽量避免；
3. 头文件保护（防止重复包含[第一篇](#define-的保护)）可以无视该原则。

### 非ASCII字符（Non-ASCII Characters）[必须]
尽量不使用非ASCII字符，使用时必须使用UTF-8格式。

### 空格还是制表位（Spacesvs.Tabs）[必须]
只使用空格，每次缩进**2个空格**。

使用空格进行缩进，**不要在代码中使用tabs**，设定编辑器将tab转为空格。

### 函数声明与定义（Function Declarations and Definitions）
返回类型和函数名在同一行，合适的话，参数也放在同一行。

函数看上去像这样：

```c++
ReturnType ClassName::FunctionName(Type par_name1,Type par_name2){
  DoSomething();
  ...
}
```

如果同一行文本较多，容不下所有参数：

```c++
ReturnType ClassName::ReallyLongFunctionName(Typepar_name1,
                                             Typepar_name2,
                                             Typepar_name3){
  DoSomething();
  ...
}
```

甚至连第一个参数都放不下：

```c++
ReturnType LongClassName::ReallyReallyReallyLongFunctionName(
    Typepar_name1,// 4 space indent
    Typepar_name2,
    Typepar_name3){
  DoSomething(); // 2 space indent
  ...
}
```

**注意以下几点**：
1. 返回值总是和函数名在同一行；
2. 左圆括号（open parenthesis）总是和函数名在同一行；
3. 函数名和左圆括号间没有空格；
4. 圆括号与参数间没有空格；
5. 左大括号（open curly brace）总在最后一个参数同一行的末尾处；
6. 右大括号（close curly brace）总是单独位于函数最后一行；
7. 右圆括号（close parenthesis）和左大括号间总是有一个空格；
8. 函数声明和实现处的所有形参名称必须保持一致；
9. 所有形参应尽可能对齐；
10. 缺省缩进为2个空格；
11. 独立封装的参数保持4个空格的缩进。

如果函数为const的，关键字const应与最后一个参数位于同一行。

```c++
//Everything in this function signature fits on a single line
ReturnType FunctionName(Type par) const {
  ...
}

//This function signaturere quires multiplelines,but
//the const keyword is on the line with the last parameter.
ReturnType ReallyLongFunctionName(Typepar1,
                                  Typepar2) const {
  ...
}
```

如果有些参数没有用到，在函数定义处将参数名注释起来：

```c++
//Always have named parameters in interfaces.
class Shape{
public:
  virtual void Rotate(double radians) = 0;
}

//Alwayshavenamedparametersinthedeclaration.
class Circle: public Shape{
public:
  virtual void Rotate(double radians);
}

// Comment out unused named parameters in definitions.
void Circle::Rotate(double/*radians*/){}

//Bad-if someone wants to implement later,it's not clear what the
//variable means.
void Circle::Rotate(double){}
```

### 函数调用（Function Calls）
尽量放在同一行，否则，将实参封装在圆括号中。

函数调用遵循如下形式：

```c++
bool retval = DoSomething(argument1, argument2, argument3);
```

如果同一行放不下，可断为多行，后面每一行都和第一个实参对齐，左圆括号后和右圆括号前不要留空格：

```c++
bool retval = DoSomething(averyveryveryverylongargument1, 
                          argument2, argument3);
```

如果函数参数比较多，可以出于可读性的考虑每行只放一个参数：

```c++
boolretval=DoSomething(argument1,
                       argument2,
                       argument3,
                       argument4);
```

如果函数名太长，以至于超过行最大长度，可以将所有参数独立成行：

```c++
if(...){
  ...
  ...
  if(...){
    DoSomethingThatRequiresALongFunctionName(
        ery_long_argument1, // 4 space indent
        argument2,
        argument3,
        argument4);
  }
}
```

### 条件语句（Conditionals）
不在圆括号中添加空格，关键字else另起一行。

```c++
if (condition) { //no spaces inside parentheses
  ...  // 2 space indent.
}else{//The else goes on the same line as the closing brace
  ....
}
```

- 注意if和左圆括号间有个空格，右圆括号和左大括号（如果使用的话）间也要有个空格。
- 有些条件语句写在同一行以增强可读性，只有当语句简单并且没有使用else子句时使用，如果语句有else分支是不允许的。
- 通常，单行语句不需要使用大括号，如果你喜欢也无可厚非，也有人要求if必须使用大括号，但如果语句中哪一分支使用了大括号的话，其他部分也必须使用。

### 循环和开关选择语句（Switch Statements）
switch语句可以使用大括号分块；空循环体应使用{}或continue。

switch语句中的case块可以使用大括号也可以不用，取决于你的喜好，使用时要依下文所述。

如果有不满足case枚举条件的值，要总是包含一个default（如果有输入值没有case去处理，编译器将报警）。如果default永不会执行，可以简单的使用assert：

```c++
switch (var) {
  case0:{//2 space indent
  ... // 4 space indent
  break;
  }
  case1:{
    ...
    break;
  }
  default:{
    assert(false);
  }
}+
```

空循环体应使用{}或continue，而不是一个简单的分号：

```c++
while (condition) {
  //Repeat test until it returns false.
  }
  for (inti=0; i<kSomeNumber; ++i) {}//Good-emptybody.
  while (condition) continue; //Good-continue indicates no logic.
  while(condition); //Bad-looks like part of do/while loop
```

### 指针和引用表达式（Pointers and Reference）
句点（.）或箭头（->）前后不要有空格，指针/地址操作符（*、&）后不要有空格。

在声明指针变量或参数时，星号与变量名紧挨:

```c++
//These are fine,space preceding.
char *c;
const string &str;

x = *p;
p = &x;
x = r.y;
x = r->y;
```

### 布尔表达式（Boolean Expressions）
如果一个布尔表达式超过标准行宽（80字符），如果断行则逻辑操作符总位于行尾。

例如：

```c++
if (this_one_thing > this_other_thing &&
    a_third_thing == a_fourth_thing &&
    yet_another & last_one) {
  ...
}
```

两个逻辑与（&&）操作符都位于行尾，**可以考虑额外插入圆括号，合理使用的话对增强可读性**是很有帮助的。

### 类格式（Class Format）
1. 声明属性依次序是public:、protected:、private:，可以考虑缩进1个空格（可以不缩进）
2. 除第一个关键词（一般是public）外，其他关键词前空一行，如果类比较小的话也可以不空，这些关键词后不要空行；
3. 基类名应在80列限制下尽量与子类名放在同一行；


### 初始化列表（Initializer Lists）
构造函数初始化列表放在同一行或按四格缩进并排几行。

两种可以接受的初始化列表格式：
```c++
//When it all fits on one line:
MyClass::MyClass(int var):some_var_(var),some_other_var_(var + 1) {}
  
//When it requires multiple lines, indent 4 spaces, putting the colonon
//the first initializer line:
MyClass::MyClass(int var)
    : some_var_(var),          //4 space indent
      some_other_var_(var + 1){  //lined up
  ...
  DoSomething();
  ...
}
```


### 其他补充格式
1. return表达式中不要使用圆括号。
2. 预处理指令不要缩进，从行首开始。
3. 命名空间内容不缩进
4. 水平留白的使用因地制宜。不要在行尾添加无谓的留白。
5. 垂直留白越少越好。<br>这不仅仅是规则而是原则问题了：**不是非常有必要的话就不要使用空行。尤其是：不要在两个函数定义之间空超过2行，函数体头、尾不要有空行，函数体中也不要随意添加空行。**

## 其他补充规范
1. 并不是只在记录日志时使用流，不过尽量采用QT封装好的流操作进行流数据的操作，而不是自己重载流操作符。
2. 强烈建议你在任何可以使用的情况下都要使用`const`
3. 使用宏时要谨慎，尽量以内联函数、枚举和常量代替之。
4. 代码文件采用UTF-8的编码格式