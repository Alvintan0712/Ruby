# 简易电子商务系统



#### 数据库设计

用户表 User（用户 id，用户名，用户邮箱，用户密码，角色，余额）*角色：Admin、Staff、Normal*  TODO: Remove Role

店铺表 Shop（店铺 id，商店名称，商家id）

Image 表 Image（image id，商品 id，image path）TODO: Add Image On Product

商品表 Product （商品 id，商品名称，商品描述，specifications，店铺 id，类别 id）

产品表 Item （产品 id。商品 id，价格，库存，销量，产品属性）

收藏夹表 Favourite（Favourite id，用户 id，产品id）

订单表 Order（订单 id，顾客 id，商品 id，电话，顾客地址，总额，状态）

订单项表 OrderItem（订单项 id，所属订单 id，产品 id，数量，价格）

Followship（关系 id，商店 id，用户id）

Rate（rate id，顾客 id，Product id，review）



main TODO: customize UI

