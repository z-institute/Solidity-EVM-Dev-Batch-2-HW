# h7

- flash loan 的運作方式與應用場景：
快速借貸出一筆錢，並在一個區塊的時間歸還這筆錢，若歸還的數量和原來不同，則交易會失敗
#### 應用
1. 因為借貸幾乎不需要成本，因此許多人會應用在套利上，只要找到>=2種代幣的匯率差，就可以進行套利，但是困難的點就是，很多人都在進行這個動作，需要知道defi protocol的價格來源，才有機會成功。
2. 也會應用在池子的攻擊，透過閃電貸攻擊池子，讓如果幣價只是使用x*y=k的方式計算的話，只要買入y，x的價格就會飆升，那再把x賣到其他LP池子，償還貸來的錢，就可以賺取價差。



### Aave flash loan

- deploy contract (use Polygon mumbai network)
- https://mumbai.polygonscan.com/tx/0xcb72d7fc556c0ff4daa53b364c0afa0caf047662b630e5de1a7d2fa8565128ef

- ![](https://i.imgur.com/iAohkUo.png)

- call flashloan failed
- ![](https://i.imgur.com/G1twcYj.png)


### rainbowKit App
- quick start a demo app
![](https://i.imgur.com/wr9LrS7.png)
