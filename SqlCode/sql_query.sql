-- 用stock数据库
use stock;
-- 删除表
drop table orders;
drop table trade;
-- 创建表
CREATE TABLE IF NOT EXISTS orders (
    order_id INT,
    symbol VARCHAR(10),
    quantity INT,
    price DECIMAL(4 , 2 ),
    direction VARCHAR(4),
    PRIMARY KEY (order_id)
);
CREATE TABLE IF NOT EXISTS trade (
    trade_id INT,
    order_id INT,
    quantity INT,
    price DECIMAL(4 , 2 ),
    PRIMARY KEY (trade_id)
);
-- 插入数据
insert into orders values(1, '000001.SZ',5000,11.5,'买入');
insert into orders values(2, '600000.SH',6000,12.5,'卖出');
insert into orders values(3, '300000.SH',6000,13.5,'买入');

insert into trade values(1,1,500,11.4);
insert into trade values(2,1,1500,11.5);
insert into trade values(3,2,6000,12.5);
-- 查询所有订单成交数据和成交均价
SELECT 
    order_id,
    SUM(quantity) quantity,
    SUM(trade_money) / SUM(quantity) average_price
FROM
    (SELECT 
        trade.quantity quantity,
            trade.price price,
            orders.order_id order_id,
            trade.price * trade.quantity trade_money
    FROM
        trade
    RIGHT JOIN orders ON trade.order_id = orders.order_id) a
GROUP BY order_id;
-- 查询每个股票的买入成交金额和卖出成交金额
select symbol, direction, sum(trade_money) trade_money from
(SELECT 
    orders.symbol symbol,
    orders.direction direction,
    trade.price * trade.quantity trade_money
FROM
    trade
        RIGHT JOIN
    orders ON trade.order_id = orders.order_id)a
GROUP BY symbol, direction;
-- 查询每笔订单的交易费用
SELECT 
    order_id,
    CASE
        WHEN fees = 0 THEN 0
        WHEN fees > 0 AND fees < 5 THEN fees = 5
        WHEN fees > 5 THEN fees
    END AS fees
FROM
    (SELECT 
        order_id, SUM(fee) fees
    FROM
        (SELECT 
        orders.order_id order_id,
            trade.price * trade.quantity * 0.0005 fee
    FROM
        trade
    LEFT JOIN orders ON trade.order_id = orders.order_id) a
    GROUP BY order_id) b;
