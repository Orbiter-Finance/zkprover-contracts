
object "plonk_verifier" {
    code {
        function allocate(size) -> ptr {
            ptr := mload(0x40)
            if eq(ptr, 0) { ptr := 0x60 }
            mstore(0x40, add(ptr, size))
        }
        let size := datasize("Runtime")
        let offset := allocate(size)
        datacopy(offset, dataoffset("Runtime"), size)
        return(offset, size)
    }
    object "Runtime" {
        code {
            let success:bool := true
            let f_p := 0x30644e72e131a029b85045b68181585d97816a916871ca8d3c208c16d87cfd47
            let f_q := 0x30644e72e131a029b85045b68181585d2833e84879b9709143e1f593f0000001
            function validate_ec_point(x, y) -> valid:bool {
                {
                    let x_lt_p:bool := lt(x, 0x30644e72e131a029b85045b68181585d97816a916871ca8d3c208c16d87cfd47)
                    let y_lt_p:bool := lt(y, 0x30644e72e131a029b85045b68181585d97816a916871ca8d3c208c16d87cfd47)
                    valid := and(x_lt_p, y_lt_p)
                }
                {
                    let y_square := mulmod(y, y, 0x30644e72e131a029b85045b68181585d97816a916871ca8d3c208c16d87cfd47)
                    let x_square := mulmod(x, x, 0x30644e72e131a029b85045b68181585d97816a916871ca8d3c208c16d87cfd47)
                    let x_cube := mulmod(x_square, x, 0x30644e72e131a029b85045b68181585d97816a916871ca8d3c208c16d87cfd47)
                    let x_cube_plus_3 := addmod(x_cube, 3, 0x30644e72e131a029b85045b68181585d97816a916871ca8d3c208c16d87cfd47)
                    let is_affine:bool := eq(x_cube_plus_3, y_square)
                    valid := and(valid, is_affine)
                }
            }
            mstore(0x20, mod(calldataload(0x0), f_q))
            mstore(0x0, 13841180651620720998163126903026136533249122931901477295877184385316012324177)

            {
                let x := calldataload(0x20)
                mstore(0x40, x)
                let y := calldataload(0x40)
                mstore(0x60, y)
                success := and(validate_ec_point(x, y), success)
            }

            {
                let x := calldataload(0x60)
                mstore(0x80, x)
                let y := calldataload(0x80)
                mstore(0xa0, y)
                success := and(validate_ec_point(x, y), success)
            }

            {
                let x := calldataload(0xa0)
                mstore(0xc0, x)
                let y := calldataload(0xc0)
                mstore(0xe0, y)
                success := and(validate_ec_point(x, y), success)
            }
            mstore(0x100, keccak256(0x0, 256))
            {
                let hash := mload(0x100)
                mstore(0x120, mod(hash, f_q))
                mstore(0x140, hash)
            }
            mstore8(352, 1)
            mstore(0x160, keccak256(0x140, 33))
            {
                let hash := mload(0x160)
                mstore(0x180, mod(hash, f_q))
                mstore(0x1a0, hash)
            }
            mstore8(448, 1)
            mstore(0x1c0, keccak256(0x1a0, 33))
            {
                let hash := mload(0x1c0)
                mstore(0x1e0, mod(hash, f_q))
                mstore(0x200, hash)
            }

            {
                let x := calldataload(0xe0)
                mstore(0x220, x)
                let y := calldataload(0x100)
                mstore(0x240, y)
                success := and(validate_ec_point(x, y), success)
            }

            {
                let x := calldataload(0x120)
                mstore(0x260, x)
                let y := calldataload(0x140)
                mstore(0x280, y)
                success := and(validate_ec_point(x, y), success)
            }

            {
                let x := calldataload(0x160)
                mstore(0x2a0, x)
                let y := calldataload(0x180)
                mstore(0x2c0, y)
                success := and(validate_ec_point(x, y), success)
            }

            {
                let x := calldataload(0x1a0)
                mstore(0x2e0, x)
                let y := calldataload(0x1c0)
                mstore(0x300, y)
                success := and(validate_ec_point(x, y), success)
            }

            {
                let x := calldataload(0x1e0)
                mstore(0x320, x)
                let y := calldataload(0x200)
                mstore(0x340, y)
                success := and(validate_ec_point(x, y), success)
            }
            mstore(0x360, keccak256(0x200, 352))
            {
                let hash := mload(0x360)
                mstore(0x380, mod(hash, f_q))
                mstore(0x3a0, hash)
            }

            {
                let x := calldataload(0x220)
                mstore(0x3c0, x)
                let y := calldataload(0x240)
                mstore(0x3e0, y)
                success := and(validate_ec_point(x, y), success)
            }

            {
                let x := calldataload(0x260)
                mstore(0x400, x)
                let y := calldataload(0x280)
                mstore(0x420, y)
                success := and(validate_ec_point(x, y), success)
            }
            mstore(0x440, keccak256(0x3a0, 160))
            {
                let hash := mload(0x440)
                mstore(0x460, mod(hash, f_q))
                mstore(0x480, hash)
            }
            mstore(0x4a0, mod(calldataload(0x2a0), f_q))
            mstore(0x4c0, mod(calldataload(0x2c0), f_q))
            mstore(0x4e0, mod(calldataload(0x2e0), f_q))
            mstore(0x500, mod(calldataload(0x300), f_q))
            mstore(0x520, mod(calldataload(0x320), f_q))
            mstore(0x540, mod(calldataload(0x340), f_q))
            mstore(0x560, mod(calldataload(0x360), f_q))
            mstore(0x580, mod(calldataload(0x380), f_q))
            mstore(0x5a0, mod(calldataload(0x3a0), f_q))
            mstore(0x5c0, mod(calldataload(0x3c0), f_q))
            mstore(0x5e0, mod(calldataload(0x3e0), f_q))
            mstore(0x600, mod(calldataload(0x400), f_q))
            mstore(0x620, mod(calldataload(0x420), f_q))
            mstore(0x640, mod(calldataload(0x440), f_q))
            mstore(0x660, mod(calldataload(0x460), f_q))
            mstore(0x680, mod(calldataload(0x480), f_q))
            mstore(0x6a0, mod(calldataload(0x4a0), f_q))
            mstore(0x6c0, mod(calldataload(0x4c0), f_q))
            mstore(0x6e0, mod(calldataload(0x4e0), f_q))
            mstore(0x700, mod(calldataload(0x500), f_q))
            mstore(0x720, keccak256(0x480, 672))
            {
                let hash := mload(0x720)
                mstore(0x740, mod(hash, f_q))
                mstore(0x760, hash)
            }

            {
                let x := calldataload(0x520)
                mstore(0x780, x)
                let y := calldataload(0x540)
                mstore(0x7a0, y)
                success := and(validate_ec_point(x, y), success)
            }

            {
                let x := calldataload(0x560)
                mstore(0x7c0, x)
                let y := calldataload(0x580)
                mstore(0x7e0, y)
                success := and(validate_ec_point(x, y), success)
            }

            {
                let x := calldataload(0x5a0)
                mstore(0x800, x)
                let y := calldataload(0x5c0)
                mstore(0x820, y)
                success := and(validate_ec_point(x, y), success)
            }
            mstore(0x840, keccak256(0x760, 224))
            {
                let hash := mload(0x840)
                mstore(0x860, mod(hash, f_q))
                mstore(0x880, hash)
            }
            mstore(0x8a0, mulmod(mload(0x460), mload(0x460), f_q))
            mstore(0x8c0, mulmod(mload(0x8a0), mload(0x8a0), f_q))
            mstore(0x8e0, mulmod(mload(0x8c0), mload(0x8c0), f_q))
            mstore(0x900, mulmod(mload(0x8e0), mload(0x8e0), f_q))
            mstore(0x920, mulmod(mload(0x900), mload(0x900), f_q))
            mstore(0x940, mulmod(mload(0x920), mload(0x920), f_q))
            mstore(0x960, mulmod(mload(0x940), mload(0x940), f_q))
            mstore(0x980, mulmod(mload(0x960), mload(0x960), f_q))
            mstore(0x9a0, addmod(mload(0x980), 21888242871839275222246405745257275088548364400416034343698204186575808495616, f_q))
            mstore(0x9c0, mulmod(mload(0x9a0), 21802741923121153053409505722814863857733722351976909209543133076471996743681, f_q))
            mstore(0x9e0, mulmod(mload(0x9c0), 10167250710514084151592399827148084713285735496006016499965216114801401041468, f_q))
            mstore(0xa00, addmod(mload(0x460), 11720992161325191070654005918109190375262628904410017843732988071774407454149, f_q))
            mstore(0xa20, mulmod(mload(0x9c0), 15620430616972136973029697708057142747056669543503469918700292712864029815878, f_q))
            mstore(0xa40, addmod(mload(0x460), 6267812254867138249216708037200132341491694856912564424997911473711778679739, f_q))
            mstore(0xa60, mulmod(mload(0x9c0), 4658854783519236281304787251426829785380272013053939496434657852755686889074, f_q))
            mstore(0xa80, addmod(mload(0x460), 17229388088320038940941618493830445303168092387362094847263546333820121606543, f_q))
            mstore(0xaa0, mulmod(mload(0x9c0), 11423757818648818765461327411617109120243501240676889555478397529313037714234, f_q))
            mstore(0xac0, addmod(mload(0x460), 10464485053190456456785078333640165968304863159739144788219806657262770781383, f_q))
            mstore(0xae0, mulmod(mload(0x9c0), 13677048343952077794467995888380402608453928821079198134318291065290235358859, f_q))
            mstore(0xb00, addmod(mload(0x460), 8211194527887197427778409856876872480094435579336836209379913121285573136758, f_q))
            mstore(0xb20, mulmod(mload(0x9c0), 14158528901797138466244491986759313854666262535363044392173788062030301470987, f_q))
            mstore(0xb40, addmod(mload(0x460), 7729713970042136756001913758497961233882101865052989951524416124545507024630, f_q))
            mstore(0xb60, mulmod(mload(0x9c0), 1, f_q))
            mstore(0xb80, addmod(mload(0x460), 21888242871839275222246405745257275088548364400416034343698204186575808495616, f_q))
            {
                let prod := mload(0xa00)

                    prod := mulmod(mload(0xa40), prod, f_q)
                    mstore(0xba0, prod)
                
                    prod := mulmod(mload(0xa80), prod, f_q)
                    mstore(0xbc0, prod)
                
                    prod := mulmod(mload(0xac0), prod, f_q)
                    mstore(0xbe0, prod)
                
                    prod := mulmod(mload(0xb00), prod, f_q)
                    mstore(0xc00, prod)
                
                    prod := mulmod(mload(0xb40), prod, f_q)
                    mstore(0xc20, prod)
                
                    prod := mulmod(mload(0xb80), prod, f_q)
                    mstore(0xc40, prod)
                
                    prod := mulmod(mload(0x9a0), prod, f_q)
                    mstore(0xc60, prod)
                
            }
            mstore(0xca0, 32)
            mstore(0xcc0, 32)
            mstore(0xce0, 32)
            mstore(0xd00, mload(0xc60))
            mstore(0xd20, 21888242871839275222246405745257275088548364400416034343698204186575808495615)
            mstore(0xd40, 21888242871839275222246405745257275088548364400416034343698204186575808495617)
            success := and(eq(staticcall(gas(), 0x5, 0xca0, 0xc0, 0xc80, 0x20), 1), success)
            {
                
                let inv := mload(0xc80)
                let v

                        v := mload(0x9a0)
                        mstore(2464, mulmod(mload(0xc40), inv, f_q))
                        inv := mulmod(v, inv, f_q)
                    
                        v := mload(0xb80)
                        mstore(2944, mulmod(mload(0xc20), inv, f_q))
                        inv := mulmod(v, inv, f_q)
                    
                        v := mload(0xb40)
                        mstore(2880, mulmod(mload(0xc00), inv, f_q))
                        inv := mulmod(v, inv, f_q)
                    
                        v := mload(0xb00)
                        mstore(2816, mulmod(mload(0xbe0), inv, f_q))
                        inv := mulmod(v, inv, f_q)
                    
                        v := mload(0xac0)
                        mstore(2752, mulmod(mload(0xbc0), inv, f_q))
                        inv := mulmod(v, inv, f_q)
                    
                        v := mload(0xa80)
                        mstore(2688, mulmod(mload(0xba0), inv, f_q))
                        inv := mulmod(v, inv, f_q)
                    
                        v := mload(0xa40)
                        mstore(2624, mulmod(mload(0xa00), inv, f_q))
                        inv := mulmod(v, inv, f_q)
                    mstore(0xa00, inv)

            }
            mstore(0xd60, mulmod(mload(0x9e0), mload(0xa00), f_q))
            mstore(0xd80, mulmod(mload(0xa20), mload(0xa40), f_q))
            mstore(0xda0, mulmod(mload(0xa60), mload(0xa80), f_q))
            mstore(0xdc0, mulmod(mload(0xaa0), mload(0xac0), f_q))
            mstore(0xde0, mulmod(mload(0xae0), mload(0xb00), f_q))
            mstore(0xe00, mulmod(mload(0xb20), mload(0xb40), f_q))
            mstore(0xe20, mulmod(mload(0xb60), mload(0xb80), f_q))
            {
                let result := mulmod(mload(0xe20), mload(0x20), f_q)
                mstore(3648, result)
            }
            mstore(0xe60, addmod(mload(0x4a0), mload(0x4c0), f_q))
            mstore(0xe80, addmod(mload(0xe60), sub(f_q, mload(0x4e0)), f_q))
            mstore(0xea0, mulmod(mload(0xe80), mload(0x500), f_q))
            mstore(0xec0, mulmod(mload(0x380), mload(0xea0), f_q))
            mstore(0xee0, addmod(1, sub(f_q, mload(0x5c0)), f_q))
            mstore(0xf00, mulmod(mload(0xee0), mload(0xe20), f_q))
            mstore(0xf20, addmod(mload(0xec0), mload(0xf00), f_q))
            mstore(0xf40, mulmod(mload(0x380), mload(0xf20), f_q))
            mstore(0xf60, mulmod(mload(0x6e0), mload(0x6e0), f_q))
            mstore(0xf80, addmod(mload(0xf60), sub(f_q, mload(0x6e0)), f_q))
            mstore(0xfa0, mulmod(mload(0xf80), mload(0xd60), f_q))
            mstore(0xfc0, addmod(mload(0xf40), mload(0xfa0), f_q))
            mstore(0xfe0, mulmod(mload(0x380), mload(0xfc0), f_q))
            mstore(0x1000, addmod(mload(0x620), sub(f_q, mload(0x600)), f_q))
            mstore(0x1020, mulmod(mload(0x1000), mload(0xe20), f_q))
            mstore(0x1040, addmod(mload(0xfe0), mload(0x1020), f_q))
            mstore(0x1060, mulmod(mload(0x380), mload(0x1040), f_q))
            mstore(0x1080, addmod(mload(0x680), sub(f_q, mload(0x660)), f_q))
            mstore(0x10a0, mulmod(mload(0x1080), mload(0xe20), f_q))
            mstore(0x10c0, addmod(mload(0x1060), mload(0x10a0), f_q))
            mstore(0x10e0, mulmod(mload(0x380), mload(0x10c0), f_q))
            mstore(0x1100, addmod(mload(0x6e0), sub(f_q, mload(0x6c0)), f_q))
            mstore(0x1120, mulmod(mload(0x1100), mload(0xe20), f_q))
            mstore(0x1140, addmod(mload(0x10e0), mload(0x1120), f_q))
            mstore(0x1160, mulmod(mload(0x380), mload(0x1140), f_q))
            mstore(0x1180, addmod(1, sub(f_q, mload(0xd60)), f_q))
            mstore(0x11a0, addmod(mload(0xd80), mload(0xda0), f_q))
            mstore(0x11c0, addmod(mload(0x11a0), mload(0xdc0), f_q))
            mstore(0x11e0, addmod(mload(0x11c0), mload(0xde0), f_q))
            mstore(0x1200, addmod(mload(0x11e0), mload(0xe00), f_q))
            mstore(0x1220, addmod(mload(0x1180), sub(f_q, mload(0x1200)), f_q))
            mstore(0x1240, mulmod(mload(0x540), mload(0x180), f_q))
            mstore(0x1260, addmod(mload(0x4a0), mload(0x1240), f_q))
            mstore(0x1280, addmod(mload(0x1260), mload(0x1e0), f_q))
            mstore(0x12a0, mulmod(mload(0x1280), mload(0x5e0), f_q))
            mstore(0x12c0, mulmod(1, mload(0x180), f_q))
            mstore(0x12e0, mulmod(mload(0x460), mload(0x12c0), f_q))
            mstore(0x1300, addmod(mload(0x4a0), mload(0x12e0), f_q))
            mstore(0x1320, addmod(mload(0x1300), mload(0x1e0), f_q))
            mstore(0x1340, mulmod(mload(0x1320), mload(0x5c0), f_q))
            mstore(0x1360, addmod(mload(0x12a0), sub(f_q, mload(0x1340)), f_q))
            mstore(0x1380, mulmod(mload(0x1360), mload(0x1220), f_q))
            mstore(0x13a0, addmod(mload(0x1160), mload(0x1380), f_q))
            mstore(0x13c0, mulmod(mload(0x380), mload(0x13a0), f_q))
            mstore(0x13e0, mulmod(mload(0x560), mload(0x180), f_q))
            mstore(0x1400, addmod(mload(0x4c0), mload(0x13e0), f_q))
            mstore(0x1420, addmod(mload(0x1400), mload(0x1e0), f_q))
            mstore(0x1440, mulmod(mload(0x1420), mload(0x640), f_q))
            mstore(0x1460, mulmod(4131629893567559867359510883348571134090853742863529169391034518566172092834, mload(0x180), f_q))
            mstore(0x1480, mulmod(mload(0x460), mload(0x1460), f_q))
            mstore(0x14a0, addmod(mload(0x4c0), mload(0x1480), f_q))
            mstore(0x14c0, addmod(mload(0x14a0), mload(0x1e0), f_q))
            mstore(0x14e0, mulmod(mload(0x14c0), mload(0x620), f_q))
            mstore(0x1500, addmod(mload(0x1440), sub(f_q, mload(0x14e0)), f_q))
            mstore(0x1520, mulmod(mload(0x1500), mload(0x1220), f_q))
            mstore(0x1540, addmod(mload(0x13c0), mload(0x1520), f_q))
            mstore(0x1560, mulmod(mload(0x380), mload(0x1540), f_q))
            mstore(0x1580, mulmod(mload(0x580), mload(0x180), f_q))
            mstore(0x15a0, addmod(mload(0x4e0), mload(0x1580), f_q))
            mstore(0x15c0, addmod(mload(0x15a0), mload(0x1e0), f_q))
            mstore(0x15e0, mulmod(mload(0x15c0), mload(0x6a0), f_q))
            mstore(0x1600, mulmod(8910878055287538404433155982483128285667088683464058436815641868457422632747, mload(0x180), f_q))
            mstore(0x1620, mulmod(mload(0x460), mload(0x1600), f_q))
            mstore(0x1640, addmod(mload(0x4e0), mload(0x1620), f_q))
            mstore(0x1660, addmod(mload(0x1640), mload(0x1e0), f_q))
            mstore(0x1680, mulmod(mload(0x1660), mload(0x680), f_q))
            mstore(0x16a0, addmod(mload(0x15e0), sub(f_q, mload(0x1680)), f_q))
            mstore(0x16c0, mulmod(mload(0x16a0), mload(0x1220), f_q))
            mstore(0x16e0, addmod(mload(0x1560), mload(0x16c0), f_q))
            mstore(0x1700, mulmod(mload(0x380), mload(0x16e0), f_q))
            mstore(0x1720, mulmod(mload(0x5a0), mload(0x180), f_q))
            mstore(0x1740, addmod(mload(0xe40), mload(0x1720), f_q))
            mstore(0x1760, addmod(mload(0x1740), mload(0x1e0), f_q))
            mstore(0x1780, mulmod(mload(0x1760), mload(0x700), f_q))
            mstore(0x17a0, mulmod(11166246659983828508719468090013646171463329086121580628794302409516816350802, mload(0x180), f_q))
            mstore(0x17c0, mulmod(mload(0x460), mload(0x17a0), f_q))
            mstore(0x17e0, addmod(mload(0xe40), mload(0x17c0), f_q))
            mstore(0x1800, addmod(mload(0x17e0), mload(0x1e0), f_q))
            mstore(0x1820, mulmod(mload(0x1800), mload(0x6e0), f_q))
            mstore(0x1840, addmod(mload(0x1780), sub(f_q, mload(0x1820)), f_q))
            mstore(0x1860, mulmod(mload(0x1840), mload(0x1220), f_q))
            mstore(0x1880, addmod(mload(0x1700), mload(0x1860), f_q))
            mstore(0x18a0, mulmod(mload(0x980), mload(0x980), f_q))
            mstore(0x18c0, mulmod(1, mload(0x980), f_q))
            mstore(0x18e0, mulmod(mload(0x1880), mload(0x9a0), f_q))
            mstore(0x1900, mulmod(mload(0x860), mload(0x860), f_q))
            mstore(0x1920, mulmod(mload(0x1900), mload(0x860), f_q))
            mstore(0x1940, mulmod(mload(0x740), mload(0x740), f_q))
            mstore(0x1960, mulmod(mload(0x1940), mload(0x740), f_q))
            mstore(0x1980, mulmod(mload(0x1960), mload(0x740), f_q))
            mstore(0x19a0, mulmod(mload(0x1980), mload(0x740), f_q))
            mstore(0x19c0, mulmod(mload(0x19a0), mload(0x740), f_q))
            mstore(0x19e0, mulmod(mload(0x19c0), mload(0x740), f_q))
            mstore(0x1a00, mulmod(mload(0x19e0), mload(0x740), f_q))
            mstore(0x1a20, mulmod(mload(0x1a00), mload(0x740), f_q))
            mstore(0x1a40, mulmod(mload(0x1a20), mload(0x740), f_q))
            mstore(0x1a60, mulmod(mload(0x1a40), mload(0x740), f_q))
            mstore(0x1a80, mulmod(mload(0x1a60), mload(0x740), f_q))
            mstore(0x1aa0, mulmod(mload(0x1a80), mload(0x740), f_q))
            mstore(0x1ac0, mulmod(mload(0x1aa0), mload(0x740), f_q))
            mstore(0x1ae0, mulmod(sub(f_q, mload(0x4a0)), 1, f_q))
            mstore(0x1b00, mulmod(sub(f_q, mload(0x4c0)), mload(0x740), f_q))
            mstore(0x1b20, mulmod(1, mload(0x740), f_q))
            mstore(0x1b40, addmod(mload(0x1ae0), mload(0x1b00), f_q))
            mstore(0x1b60, mulmod(sub(f_q, mload(0x4e0)), mload(0x1940), f_q))
            mstore(0x1b80, mulmod(1, mload(0x1940), f_q))
            mstore(0x1ba0, addmod(mload(0x1b40), mload(0x1b60), f_q))
            mstore(0x1bc0, mulmod(sub(f_q, mload(0x5c0)), mload(0x1960), f_q))
            mstore(0x1be0, mulmod(1, mload(0x1960), f_q))
            mstore(0x1c00, addmod(mload(0x1ba0), mload(0x1bc0), f_q))
            mstore(0x1c20, mulmod(sub(f_q, mload(0x620)), mload(0x1980), f_q))
            mstore(0x1c40, mulmod(1, mload(0x1980), f_q))
            mstore(0x1c60, addmod(mload(0x1c00), mload(0x1c20), f_q))
            mstore(0x1c80, mulmod(sub(f_q, mload(0x680)), mload(0x19a0), f_q))
            mstore(0x1ca0, mulmod(1, mload(0x19a0), f_q))
            mstore(0x1cc0, addmod(mload(0x1c60), mload(0x1c80), f_q))
            mstore(0x1ce0, mulmod(sub(f_q, mload(0x6e0)), mload(0x19c0), f_q))
            mstore(0x1d00, mulmod(1, mload(0x19c0), f_q))
            mstore(0x1d20, addmod(mload(0x1cc0), mload(0x1ce0), f_q))
            mstore(0x1d40, mulmod(sub(f_q, mload(0x500)), mload(0x19e0), f_q))
            mstore(0x1d60, mulmod(1, mload(0x19e0), f_q))
            mstore(0x1d80, addmod(mload(0x1d20), mload(0x1d40), f_q))
            mstore(0x1da0, mulmod(sub(f_q, mload(0x540)), mload(0x1a00), f_q))
            mstore(0x1dc0, mulmod(1, mload(0x1a00), f_q))
            mstore(0x1de0, addmod(mload(0x1d80), mload(0x1da0), f_q))
            mstore(0x1e00, mulmod(sub(f_q, mload(0x560)), mload(0x1a20), f_q))
            mstore(0x1e20, mulmod(1, mload(0x1a20), f_q))
            mstore(0x1e40, addmod(mload(0x1de0), mload(0x1e00), f_q))
            mstore(0x1e60, mulmod(sub(f_q, mload(0x580)), mload(0x1a40), f_q))
            mstore(0x1e80, mulmod(1, mload(0x1a40), f_q))
            mstore(0x1ea0, addmod(mload(0x1e40), mload(0x1e60), f_q))
            mstore(0x1ec0, mulmod(sub(f_q, mload(0x5a0)), mload(0x1a60), f_q))
            mstore(0x1ee0, mulmod(1, mload(0x1a60), f_q))
            mstore(0x1f00, addmod(mload(0x1ea0), mload(0x1ec0), f_q))
            mstore(0x1f20, mulmod(sub(f_q, mload(0x18e0)), mload(0x1a80), f_q))
            mstore(0x1f40, mulmod(1, mload(0x1a80), f_q))
            mstore(0x1f60, mulmod(mload(0x18c0), mload(0x1a80), f_q))
            mstore(0x1f80, addmod(mload(0x1f00), mload(0x1f20), f_q))
            mstore(0x1fa0, mulmod(sub(f_q, mload(0x520)), mload(0x1aa0), f_q))
            mstore(0x1fc0, mulmod(1, mload(0x1aa0), f_q))
            mstore(0x1fe0, addmod(mload(0x1f80), mload(0x1fa0), f_q))
            mstore(0x2000, mulmod(mload(0x1fe0), 1, f_q))
            mstore(0x2020, mulmod(mload(0x1b20), 1, f_q))
            mstore(0x2040, mulmod(mload(0x1b80), 1, f_q))
            mstore(0x2060, mulmod(mload(0x1be0), 1, f_q))
            mstore(0x2080, mulmod(mload(0x1c40), 1, f_q))
            mstore(0x20a0, mulmod(mload(0x1ca0), 1, f_q))
            mstore(0x20c0, mulmod(mload(0x1d00), 1, f_q))
            mstore(0x20e0, mulmod(mload(0x1d60), 1, f_q))
            mstore(0x2100, mulmod(mload(0x1dc0), 1, f_q))
            mstore(0x2120, mulmod(mload(0x1e20), 1, f_q))
            mstore(0x2140, mulmod(mload(0x1e80), 1, f_q))
            mstore(0x2160, mulmod(mload(0x1ee0), 1, f_q))
            mstore(0x2180, mulmod(mload(0x1f40), 1, f_q))
            mstore(0x21a0, mulmod(mload(0x1f60), 1, f_q))
            mstore(0x21c0, mulmod(mload(0x1fc0), 1, f_q))
            mstore(0x21e0, mulmod(sub(f_q, mload(0x5e0)), 1, f_q))
            mstore(0x2200, mulmod(sub(f_q, mload(0x640)), mload(0x740), f_q))
            mstore(0x2220, addmod(mload(0x21e0), mload(0x2200), f_q))
            mstore(0x2240, mulmod(sub(f_q, mload(0x6a0)), mload(0x1940), f_q))
            mstore(0x2260, addmod(mload(0x2220), mload(0x2240), f_q))
            mstore(0x2280, mulmod(sub(f_q, mload(0x700)), mload(0x1960), f_q))
            mstore(0x22a0, addmod(mload(0x2260), mload(0x2280), f_q))
            mstore(0x22c0, mulmod(mload(0x22a0), mload(0x860), f_q))
            mstore(0x22e0, mulmod(1, mload(0x860), f_q))
            mstore(0x2300, mulmod(mload(0x1b20), mload(0x860), f_q))
            mstore(0x2320, mulmod(mload(0x1b80), mload(0x860), f_q))
            mstore(0x2340, mulmod(mload(0x1be0), mload(0x860), f_q))
            mstore(0x2360, addmod(mload(0x2000), mload(0x22c0), f_q))
            mstore(0x2380, addmod(mload(0x2060), mload(0x22e0), f_q))
            mstore(0x23a0, addmod(mload(0x2080), mload(0x2300), f_q))
            mstore(0x23c0, addmod(mload(0x20a0), mload(0x2320), f_q))
            mstore(0x23e0, addmod(mload(0x20c0), mload(0x2340), f_q))
            mstore(0x2400, mulmod(sub(f_q, mload(0x6c0)), 1, f_q))
            mstore(0x2420, mulmod(sub(f_q, mload(0x660)), mload(0x740), f_q))
            mstore(0x2440, addmod(mload(0x2400), mload(0x2420), f_q))
            mstore(0x2460, mulmod(sub(f_q, mload(0x600)), mload(0x1940), f_q))
            mstore(0x2480, addmod(mload(0x2440), mload(0x2460), f_q))
            mstore(0x24a0, mulmod(mload(0x2480), mload(0x1900), f_q))
            mstore(0x24c0, mulmod(1, mload(0x1900), f_q))
            mstore(0x24e0, mulmod(mload(0x1b20), mload(0x1900), f_q))
            mstore(0x2500, mulmod(mload(0x1b80), mload(0x1900), f_q))
            mstore(0x2520, addmod(mload(0x2360), mload(0x24a0), f_q))
            mstore(0x2540, addmod(mload(0x23c0), mload(0x24c0), f_q))
            mstore(0x2560, addmod(mload(0x23a0), mload(0x24e0), f_q))
            mstore(0x2580, addmod(mload(0x2380), mload(0x2500), f_q))
            mstore(0x25a0, mulmod(1, mload(0x460), f_q))
            mstore(0x25c0, mulmod(1, mload(0x25a0), f_q))
            mstore(0x25e0, mulmod(7393649265675507591155086225434297871937368251641985215568891852805958167681, mload(0x460), f_q))
            mstore(0x2600, mulmod(mload(0x22e0), mload(0x25e0), f_q))
            mstore(0x2620, mulmod(10167250710514084151592399827148084713285735496006016499965216114801401041468, mload(0x460), f_q))
            mstore(0x2640, mulmod(mload(0x24c0), mload(0x2620), f_q))
            mstore(0x2660, 0x0000000000000000000000000000000000000000000000000000000000000001)
            mstore(0x2680, 0x0000000000000000000000000000000000000000000000000000000000000002)
            mstore(0x26a0, mload(0x2520))
            success := and(eq(staticcall(gas(), 0x7, 0x2660, 0x60, 0x2660, 0x40), 1), success)
            mstore(0x26c0, mload(0x2660))
            mstore(0x26e0, mload(0x2680))
            mstore(0x2700, mload(0x40))
            mstore(0x2720, mload(0x60))
            success := and(eq(staticcall(gas(), 0x6, 0x26c0, 0x80, 0x26c0, 0x40), 1), success)
            mstore(0x2740, mload(0x80))
            mstore(0x2760, mload(0xa0))
            mstore(0x2780, mload(0x2020))
            success := and(eq(staticcall(gas(), 0x7, 0x2740, 0x60, 0x2740, 0x40), 1), success)
            mstore(0x27a0, mload(0x26c0))
            mstore(0x27c0, mload(0x26e0))
            mstore(0x27e0, mload(0x2740))
            mstore(0x2800, mload(0x2760))
            success := and(eq(staticcall(gas(), 0x6, 0x27a0, 0x80, 0x27a0, 0x40), 1), success)
            mstore(0x2820, mload(0xc0))
            mstore(0x2840, mload(0xe0))
            mstore(0x2860, mload(0x2040))
            success := and(eq(staticcall(gas(), 0x7, 0x2820, 0x60, 0x2820, 0x40), 1), success)
            mstore(0x2880, mload(0x27a0))
            mstore(0x28a0, mload(0x27c0))
            mstore(0x28c0, mload(0x2820))
            mstore(0x28e0, mload(0x2840))
            success := and(eq(staticcall(gas(), 0x6, 0x2880, 0x80, 0x2880, 0x40), 1), success)
            mstore(0x2900, mload(0x220))
            mstore(0x2920, mload(0x240))
            mstore(0x2940, mload(0x2580))
            success := and(eq(staticcall(gas(), 0x7, 0x2900, 0x60, 0x2900, 0x40), 1), success)
            mstore(0x2960, mload(0x2880))
            mstore(0x2980, mload(0x28a0))
            mstore(0x29a0, mload(0x2900))
            mstore(0x29c0, mload(0x2920))
            success := and(eq(staticcall(gas(), 0x6, 0x2960, 0x80, 0x2960, 0x40), 1), success)
            mstore(0x29e0, mload(0x260))
            mstore(0x2a00, mload(0x280))
            mstore(0x2a20, mload(0x2560))
            success := and(eq(staticcall(gas(), 0x7, 0x29e0, 0x60, 0x29e0, 0x40), 1), success)
            mstore(0x2a40, mload(0x2960))
            mstore(0x2a60, mload(0x2980))
            mstore(0x2a80, mload(0x29e0))
            mstore(0x2aa0, mload(0x2a00))
            success := and(eq(staticcall(gas(), 0x6, 0x2a40, 0x80, 0x2a40, 0x40), 1), success)
            mstore(0x2ac0, mload(0x2a0))
            mstore(0x2ae0, mload(0x2c0))
            mstore(0x2b00, mload(0x2540))
            success := and(eq(staticcall(gas(), 0x7, 0x2ac0, 0x60, 0x2ac0, 0x40), 1), success)
            mstore(0x2b20, mload(0x2a40))
            mstore(0x2b40, mload(0x2a60))
            mstore(0x2b60, mload(0x2ac0))
            mstore(0x2b80, mload(0x2ae0))
            success := and(eq(staticcall(gas(), 0x6, 0x2b20, 0x80, 0x2b20, 0x40), 1), success)
            mstore(0x2ba0, mload(0x2e0))
            mstore(0x2bc0, mload(0x300))
            mstore(0x2be0, mload(0x23e0))
            success := and(eq(staticcall(gas(), 0x7, 0x2ba0, 0x60, 0x2ba0, 0x40), 1), success)
            mstore(0x2c00, mload(0x2b20))
            mstore(0x2c20, mload(0x2b40))
            mstore(0x2c40, mload(0x2ba0))
            mstore(0x2c60, mload(0x2bc0))
            success := and(eq(staticcall(gas(), 0x6, 0x2c00, 0x80, 0x2c00, 0x40), 1), success)
            mstore(0x2c80, 0x15462a626cdda97d18cac2b30bf3726b46f111e583a2f775e4c5ff96d6662e95)
            mstore(0x2ca0, 0x09d79fb64a96e8e034c33e8b058ea0054f34aac0c466376ca687019b45313d68)
            mstore(0x2cc0, mload(0x20e0))
            success := and(eq(staticcall(gas(), 0x7, 0x2c80, 0x60, 0x2c80, 0x40), 1), success)
            mstore(0x2ce0, mload(0x2c00))
            mstore(0x2d00, mload(0x2c20))
            mstore(0x2d20, mload(0x2c80))
            mstore(0x2d40, mload(0x2ca0))
            success := and(eq(staticcall(gas(), 0x6, 0x2ce0, 0x80, 0x2ce0, 0x40), 1), success)
            mstore(0x2d60, 0x2cd6de78aebcfbac7f39bd688589901b9f9ed725a0ad2ec42b2972dbe0557700)
            mstore(0x2d80, 0x0eed7231b233bec42631b307fd6e6c8928e344763cd279a5baef44be1242e0ed)
            mstore(0x2da0, mload(0x2100))
            success := and(eq(staticcall(gas(), 0x7, 0x2d60, 0x60, 0x2d60, 0x40), 1), success)
            mstore(0x2dc0, mload(0x2ce0))
            mstore(0x2de0, mload(0x2d00))
            mstore(0x2e00, mload(0x2d60))
            mstore(0x2e20, mload(0x2d80))
            success := and(eq(staticcall(gas(), 0x6, 0x2dc0, 0x80, 0x2dc0, 0x40), 1), success)
            mstore(0x2e40, 0x13b6cdde9d86922990412f89c7a2af18366cff2828a48115cd12e05b6ac9c4f6)
            mstore(0x2e60, 0x0bacde06923f632a36f66f76ed72ebb1f6b45393bcf759b5a6d6733d8fc9c18f)
            mstore(0x2e80, mload(0x2120))
            success := and(eq(staticcall(gas(), 0x7, 0x2e40, 0x60, 0x2e40, 0x40), 1), success)
            mstore(0x2ea0, mload(0x2dc0))
            mstore(0x2ec0, mload(0x2de0))
            mstore(0x2ee0, mload(0x2e40))
            mstore(0x2f00, mload(0x2e60))
            success := and(eq(staticcall(gas(), 0x6, 0x2ea0, 0x80, 0x2ea0, 0x40), 1), success)
            mstore(0x2f20, 0x213e2a6a79fbab50dc2ef3995f9bc1b6d3a03e7f68a9e4740b1276cd352b4b53)
            mstore(0x2f40, 0x2649e74ccffc6ef9a868593df00a384ae57b3656e5fd0f73f71dade14a33af5e)
            mstore(0x2f60, mload(0x2140))
            success := and(eq(staticcall(gas(), 0x7, 0x2f20, 0x60, 0x2f20, 0x40), 1), success)
            mstore(0x2f80, mload(0x2ea0))
            mstore(0x2fa0, mload(0x2ec0))
            mstore(0x2fc0, mload(0x2f20))
            mstore(0x2fe0, mload(0x2f40))
            success := and(eq(staticcall(gas(), 0x6, 0x2f80, 0x80, 0x2f80, 0x40), 1), success)
            mstore(0x3000, 0x2784f5477292d0754c06ed12e4443f0f9ebd7e11b92a14208c8876ba20975550)
            mstore(0x3020, 0x1383a1b6e6f54f75b8520e24a4bdeabe666a4b5bae45899f48655930ad1b5ab6)
            mstore(0x3040, mload(0x2160))
            success := and(eq(staticcall(gas(), 0x7, 0x3000, 0x60, 0x3000, 0x40), 1), success)
            mstore(0x3060, mload(0x2f80))
            mstore(0x3080, mload(0x2fa0))
            mstore(0x30a0, mload(0x3000))
            mstore(0x30c0, mload(0x3020))
            success := and(eq(staticcall(gas(), 0x6, 0x3060, 0x80, 0x3060, 0x40), 1), success)
            mstore(0x30e0, mload(0x3c0))
            mstore(0x3100, mload(0x3e0))
            mstore(0x3120, mload(0x2180))
            success := and(eq(staticcall(gas(), 0x7, 0x30e0, 0x60, 0x30e0, 0x40), 1), success)
            mstore(0x3140, mload(0x3060))
            mstore(0x3160, mload(0x3080))
            mstore(0x3180, mload(0x30e0))
            mstore(0x31a0, mload(0x3100))
            success := and(eq(staticcall(gas(), 0x6, 0x3140, 0x80, 0x3140, 0x40), 1), success)
            mstore(0x31c0, mload(0x400))
            mstore(0x31e0, mload(0x420))
            mstore(0x3200, mload(0x21a0))
            success := and(eq(staticcall(gas(), 0x7, 0x31c0, 0x60, 0x31c0, 0x40), 1), success)
            mstore(0x3220, mload(0x3140))
            mstore(0x3240, mload(0x3160))
            mstore(0x3260, mload(0x31c0))
            mstore(0x3280, mload(0x31e0))
            success := and(eq(staticcall(gas(), 0x6, 0x3220, 0x80, 0x3220, 0x40), 1), success)
            mstore(0x32a0, mload(0x320))
            mstore(0x32c0, mload(0x340))
            mstore(0x32e0, mload(0x21c0))
            success := and(eq(staticcall(gas(), 0x7, 0x32a0, 0x60, 0x32a0, 0x40), 1), success)
            mstore(0x3300, mload(0x3220))
            mstore(0x3320, mload(0x3240))
            mstore(0x3340, mload(0x32a0))
            mstore(0x3360, mload(0x32c0))
            success := and(eq(staticcall(gas(), 0x6, 0x3300, 0x80, 0x3300, 0x40), 1), success)
            mstore(0x3380, mload(0x780))
            mstore(0x33a0, mload(0x7a0))
            mstore(0x33c0, mload(0x25c0))
            success := and(eq(staticcall(gas(), 0x7, 0x3380, 0x60, 0x3380, 0x40), 1), success)
            mstore(0x33e0, mload(0x3300))
            mstore(0x3400, mload(0x3320))
            mstore(0x3420, mload(0x3380))
            mstore(0x3440, mload(0x33a0))
            success := and(eq(staticcall(gas(), 0x6, 0x33e0, 0x80, 0x33e0, 0x40), 1), success)
            mstore(0x3460, mload(0x7c0))
            mstore(0x3480, mload(0x7e0))
            mstore(0x34a0, mload(0x2600))
            success := and(eq(staticcall(gas(), 0x7, 0x3460, 0x60, 0x3460, 0x40), 1), success)
            mstore(0x34c0, mload(0x33e0))
            mstore(0x34e0, mload(0x3400))
            mstore(0x3500, mload(0x3460))
            mstore(0x3520, mload(0x3480))
            success := and(eq(staticcall(gas(), 0x6, 0x34c0, 0x80, 0x34c0, 0x40), 1), success)
            mstore(0x3540, mload(0x800))
            mstore(0x3560, mload(0x820))
            mstore(0x3580, mload(0x2640))
            success := and(eq(staticcall(gas(), 0x7, 0x3540, 0x60, 0x3540, 0x40), 1), success)
            mstore(0x35a0, mload(0x34c0))
            mstore(0x35c0, mload(0x34e0))
            mstore(0x35e0, mload(0x3540))
            mstore(0x3600, mload(0x3560))
            success := and(eq(staticcall(gas(), 0x6, 0x35a0, 0x80, 0x35a0, 0x40), 1), success)
            mstore(0x3620, mload(0x7c0))
            mstore(0x3640, mload(0x7e0))
            mstore(0x3660, mload(0x22e0))
            success := and(eq(staticcall(gas(), 0x7, 0x3620, 0x60, 0x3620, 0x40), 1), success)
            mstore(0x3680, mload(0x780))
            mstore(0x36a0, mload(0x7a0))
            mstore(0x36c0, mload(0x3620))
            mstore(0x36e0, mload(0x3640))
            success := and(eq(staticcall(gas(), 0x6, 0x3680, 0x80, 0x3680, 0x40), 1), success)
            mstore(0x3700, mload(0x800))
            mstore(0x3720, mload(0x820))
            mstore(0x3740, mload(0x24c0))
            success := and(eq(staticcall(gas(), 0x7, 0x3700, 0x60, 0x3700, 0x40), 1), success)
            mstore(0x3760, mload(0x3680))
            mstore(0x3780, mload(0x36a0))
            mstore(0x37a0, mload(0x3700))
            mstore(0x37c0, mload(0x3720))
            success := and(eq(staticcall(gas(), 0x6, 0x3760, 0x80, 0x3760, 0x40), 1), success)
            mstore(0x37e0, mload(0x35a0))
            mstore(0x3800, mload(0x35c0))
            mstore(0x3820, 0x198e9393920d483a7260bfb731fb5d25f1aa493335a9e71297e485b7aef312c2)
            mstore(0x3840, 0x1800deef121f1e76426a00665e5c4479674322d4f75edadd46debd5cd992f6ed)
            mstore(0x3860, 0x090689d0585ff075ec9e99ad690c3395bc4b313370b38ef355acdadcd122975b)
            mstore(0x3880, 0x12c85ea5db8c6deb4aab71808dcb408fe3d1e7690c43d37b4ce6cc0166fa7daa)
            mstore(0x38a0, mload(0x3760))
            mstore(0x38c0, mload(0x3780))
            mstore(0x38e0, 0x127721eade148c75d0860436fb015f7ba4e4d8dae1486df526b5753b1d8bcc15)
            mstore(0x3900, 0x12f74db643311c7e589565d1bc29240be831658960e6a713229f87a4ae289fc7)
            mstore(0x3920, 0x2140dbead0057b0a1ee85f5f825af0e490a090297083111d20eaef40e762ff11)
            mstore(0x3940, 0x13e34d47529d62d7c3029307550a6a90f34fbe689ef8f6c961cb705bc5bf2e9e)
            success := and(eq(staticcall(gas(), 0x8, 0x37e0, 0x180, 0x37e0, 0x20), 1), success)
            success := and(eq(mload(0x37e0), 1), success)

            if not(success) { revert(0, 0) }
            return(0, 0)

        }
    }
}