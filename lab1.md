# 作业1: case equality 调研

case equality 中 `a === b` 可以理解成，集合 a 是否包括元素 b 或元素 a 是否等于 b。

### 实验验证

`1 === 1 true` 

`1.0 === 1 true` 1.0 和 1 都被理解成同一个元素，因此返回 true

`"1" === 1 false` "1" 是字符串，不在数字集合内

`(1..2) === 2 true` 2 在 [1,2] 的范围内

`(1...2) === 2 false` 2 不再 [1,2) 的范围内

显然 `(1...3) === 2` 是 `true` 的

`"asdf" === "asdf" true` 两者都是字符串，并且都是同个元素

`/asdf/ === "asdf" true` /asdf/ 能匹配到 "asdf" 内

`/a|e|i|o|u/ === 'a' true` 'a' 包含 /a|e|i|o|u/

`Integer === 1 true` 1 是整数

`Float === 1.0 true` 1.0 是浮点数，因此包含在浮点数集合

`Integer === 1.0 false` 1.0 是浮点数，不包含在整数内

`Float === 1 false` 1 是整数，不包含在浮点数内

`1 === Integer false` 整数不包含在 1 内

因此可推出以上的解释成立。

