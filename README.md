# Ruby 大作业文档 — 基于 Rails 6 的简易电商平台

#### 一、Models 与参数的要求

**粗体为 Primary Key** ，*斜体为 Foreign Key*  

###### User

**id** , email, encrypted_password, reset_password_token, username, balance

`email` : string type，用户邮箱，要求必须存在

`encrypted_password` : string type，用户密码，要求必须存在

`reset_password_token` : string type，用户重置密码的 token

`username` : string type，用户名，要求必须存在 

`balance` : decimal type，用户余额，默认值为 $0$ 

###### Shop

**id**, name, *user_id* 

`name` : string type，店铺名称，要求必须存在 

`user_id` : references type，店家 id，要求必须存在，外码对应 User 表。

###### Product

**id**, name, description, specification, *shop_id*

`name` : string type，商品名称，要求必须存在 

`description` : string type，商品描述，要求必须存在 

`specification` : string type，商品规格，要求必须存在 

`shop_id` : references type，店铺 id，要求必须存在，外码对应 Shop 表。

###### Item

**id**, *product_id*, cost, stock, sale, properties

`product_id` : references type，商品 id，要求必须存在，外码对应 Product 表

`cost` : decimal type，产品价格，要求必须存在 

`stock` : integer type，产品库存，要求必须存在 

`sale` : integer type，产品销售量，要求必须存在 

`properties` : string type，产品特性，要求必须存在 

###### Order

**id**, *user_id*, *product_id*, address, phone, price, status, delivery

`user_id` : references type，顾客 id，外码对应 User 表

`product_id` : references type，商品 id，外码对应 Product 表

`address` : string type，顾客地址

`phone` : string type，顾客电话号码

`price` : decimal type，订单价格，要求必须存在

`status` : integer type，订单状态，默认值为 $0$ 

`delivery` : string type，订单邮寄方式

###### OrderItem

**id**, *item_id*, *order_id*, quantity, cost

`item_id` : references type，产品 id，要求必须存在，外码对应 Item 表

`order_id` : references type，订单 id，要求必须存在，外码对应 Order 表

`quantity` : integer type，订单项产品数量，要求必须存在 

`cost` : decimal type，订单项价格，要求必须存在 

###### Rate

**id**, *user_id*, *product_id*, review

`user_id` : references type，用户 id，要求必须存在，外码对应 User 表

`product_id` : references type，商品 id，要求必须存在，外码对应 Product 表

`review` : string type，用户反馈，要求必须存在 

###### Image

**id**, *product_id*, image

`product_id` : references type，商品 id，要求必须存在，外码对应 Product 表

`image` : attachment type，照片，要求必须存在。

###### Followship

**id**, *shop_id*, *user_id*

`shop_id` : references type，店铺 id，要求必须存在，外码对应 Shop 表

`user_id` : references type，用户 id，要求必须存在，外码对应 User 表

###### Favourite

**id**, *product_id*, *user_id*

`product_id` : references type，商品 id，要求必须存在，外码对应 Product 表

`user_id` : references type，用户 id，要求必须存在，外码对应 User 表



#### 二、Views 与主要功能

前端 UI 主要使用 bootstrap 作为组件库，以下将介绍各个界面

###### Application

在页面模板上实现了一个 navbar 和 footer，并在 `<%= yield >` 上放 notice 和 alert。

**navbar**

navbar 里有 Home、Order、Cart、Shop、Follows、Favourite，方便用户能直接点击到指定 url 。在 navbar 右方则为显示用户名的 dropdown，用户可以点击 dropdown 查看 Profile 和 My Wallet，也可以点击 Edit 修改用户资料或 Change Password 修改用户密码，最后可以点击 Sign Out 注销账号。 

**footer**

footer 仅有 Home 和 About

###### Home

Home 页面有一个 Search bar 方便用户搜索产品然后下方还有一个 Buy Somethings 显示一些店铺让用户去逛。

**About**

一个简单的介绍页面

**Search**

该页面显示用户的搜索结果，用户可以根据自己的搜索的结果查看 Shop 或 Product。若用户什么都不输入，则会显示所有的 Shops 和 Products。

###### Orders

该页面显示用户的所有订单，而我为订单分为四个状态 To Pay, To Send, To Receive, To Rate, Done，但 To Pay 状态的订单只会在 Cart 上显示，因此该页面只有 All（不显示 To Pay）, To Send, To Receive, To Rate 状态的订单。

To Send 的订单需等待商家发货才能进入 To Receive 状态

To Receive 的订单用户需要点击 Receive 才能进入 To Rate 状态

To Rate 的订单用户可以对商品进行评价，评价完毕就进入 Done 状态

###### Cart

该页面显示用户的 To Pay 订单，若用户想要下单可以点击订单填地址和电话号码，下单时也可改动想要的产品数量。

###### Shop

若用户没有自己的商店，则会自动跳转到创建商店的页面，用户创建了商店才能到商店管理页面。

**Manage**

商家管理页面，商家可以查看商店详情、管理商店商品以及订单，商家可以更改商店名称，可以增添商品或删除商品，商家也可以对订单进行发货或取消订单。

**Show**

用户查看页面，用户可以查看该商店的详情并决定要不要关注，也可以看到商店里的商品，并点击浏览。

###### Product

商品页面

**Description**

商品描述

**Specification**

商品规格

**Items**

列出可选择的产品，若是商家，则可以删除产品或修改产品的库存、价格及特性。若是其他用户则可以选择要买多少个产品。

###### Follows

显示用户关注的商店，并可让用户点击查看商店

###### Favourite

显示用户收藏的商品，并可让用户点击查看商品



#### 三、Controllers 与部分功能的实现细节

###### UsersController

主要使用 devise 插件的用户认证系统，保证了大部分的用户安全隐患，并且加了 username ，实现让用户能用 username 或 email 登录账号的功能。

大部分额外的功能实现都写入在 `users_controller.rb` 里，本人也将原本 Devise 默认的统一修改用户资料的方式改为 Profile 和 Password 的修改区别开来。并且在用户上加入余额 (balance) 的属性，让用户能将钱充值到账号里方便购买。在提款时用户需要输入密码才能将余额提出。

###### HomeController

主要实现了搜索功能，让用户能用关键词进行搜索找到对应的商品及商店

###### OrdersController

由于 Order 表只有买家 id 和商品 id，为了让店铺管理页面能显示订单实现了一个简单的 `order_shop` 方便提取 `shop` 。
为了保证用户是否有真的下单，在实现了 `parse_items` 的时候检查用户是否有买任何一件产品，若无则提醒用户需选择至少一件产品。
为了保证用户下单时余额充足且产品的库存足够，实现了 `enough` 检查用户的余额是否足够且产品的库存足够。
除此之外，还封装了用户下单后付款的流程，并将实现过程写在 `purchase` 里。
最后在每个流程上进行鉴权，例如只有商家才能发货、买家才能拿包裹和付款，和只有商家和买家才能查看订单等。

