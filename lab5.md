# 作业5: rails 相关 gem 功能调研

Gem 是 Ruby 类库的封装与分发格式，其中包含 Ruby 类库代码和相关元信息。Gem 可以用来扩展或修改在 Ruby 应用程序功能。 通常他们用于分发可重用的功能，与其他 Ruby 爱好者们用于共享他们的应用程序和库。 一些 Gem 提供命令行实用工具来帮助自动化任务，加快你的工作。

Ruby on Rails 是一组 gem 包的组合，安装 rails 的时候也会安装以下 gem 包：

##### ActiveJob

ActiveJob 是一个声明作业并让它们在后端的各种队列上运行的框架。ActiveJob 的主要目的是保证所有 Rails 应用程序都具有基础架构。这样就可以在该基础上构建框架功能，不必担心各种作业运行程序之间的 API 差异。

##### ActiveModel

ActiveModel 是一个包含各种模块的库，这些模块用于开发需要在 ActiveRecord 上存在的功能的类。包括以下功能：

* AttributeMethods: 添加自定义前缀和后缀，且可通过前缀和后缀对象指定使用哪些方法进行操作
* Callbacks: 提供 ActiveRecord 在适当的时机上运行回调的能力。定义了 Callbacks 后，可以使用 before、after 和 around 的自定义方法来封装它们。
* Conversion: 如果一个类定义了 `persisted?` 和 `id` 方法，那可以 include `ActiveModel::Conversion` 模块在该类上，并在该类的对象调用 Rails conversion 方法。
* Dirty: 若一个对象经过多次修改但未保存时，那它就会变 Dirty。`AcitveModel::Dirty` 可以检查对象是否经过更改，它还具有基于属性访问的方法。

##### ActiveRecord

ActiveRecord 是 MVC 中的 M，是系统中表示业务逻辑和数据的层。ActiveRecord 促进创建需要持久存储到数据库的业务对象。ActiveRecord 本身是一个 ORM 系统的描述。

##### ActiveSupport

ActiveSupport 是一组对 Rails 实用程序类和标准库的扩展，支持多字节字符串、国际化、时区和测试等。

##### ActionMailer

ActionMailer 支持用户使用邮件程序类和视图从该应用程序上发送邮件。

##### ActionPack

ActionPack 是一个用于处理和相应 web 请求的框架。它提供了路由机制，定义控制器的实现以及通过呈现视图生成相应，这些视图是各种格式的模板。

##### ActionView

在 Rails 中 Web 请求将由 ActionController 和 ActionView 来处理。一般上 ActionController 专注在数据库的交互并在必要时进行 CRUD 操作。ActionView 则负责编译i相应。

