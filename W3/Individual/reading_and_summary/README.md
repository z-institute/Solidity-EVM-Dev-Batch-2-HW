補充閱讀：閱讀完後用自己的話寫下 summary，和以開發者角度該如何避免類似問題 / 寫一個安全的智能合約需要注意哪些方面？
- 閱讀資料
    - [https://insights.glassnode.com/defi-attacks-flash-loans-centralized-price-oracles/](https://insights.glassnode.com/defi-attacks-flash-loans-centralized-price-oracles/)
    - [https://consensys.github.io/smart-contract-best-practices/](https://consensys.github.io/smart-contract-best-practices/)
- 補充
    - [https://chain.link/education/blockchain-oracles](https://chain.link/education/blockchain-oracles)

### Summary

預言機是一種預測機制，類似於我們從新聞台獲取天氣預報、保險業精算師計算未來風險等。使用戶可以從這些預測數據決定下一步的行動，例如今天今天或未來幾天的衣物該如何準備，保險合約該設定多少費用等。

而區塊鏈的預言機即是為了提供智能合約這些預測的數據以進行相對應的調整，例如提供未來一段時間的 gas fee 預測、幣價變動預測等，使智能合約，例如 DeFi 可以基於這些數據做出相對應的ˇ調整，避免損失。

然而由於預言機提供商也是經由歷史數據去預測未來趨勢，故若智能合約僅參考單一或少數幾組預言機，則容易遭受攻擊而蒙受損失。例如有攻擊者使用大量資金或漏洞使得某預言機的預測失準，若智能合約僅參考某單一預言機，則會造成合約輸出的資訊有誤，因此就可以被有心人士拿來操縱甚至從中獲取利益。

因此智能合約開發者在使用預言機時，應注意避免使用單一預言機，應使用多個預言機數據做參考，並且屏除數據異常者，避免造成合約輸出異常甚至大量損失。