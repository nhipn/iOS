import UIKit

//khai nao mang
var mangSoNguyen = [Int]()

//them phan tu vao mang
//cach 1:
mangSoNguyen.append(10)
mangSoNguyen.append(20)
//cach 2:
mangSoNguyen += [15, 65]

mangSoNguyen[1] = 99

for i in mangSoNguyen {
    print("\(i)")
}
