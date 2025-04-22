# point_sns
ポイント制度を導入したSNS
## ポイントについて
### 通常ポイント
```
(earned points)=(got points)x(point_rate)
```
ただし、小数点以下は切り捨てる。

### devise_auth_tokenについて
- current_v1_userであることに注意
- userの部分をv1_userに置換すればよい
