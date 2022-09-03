import std/[random, tables, unittest]
import ../presto/btrees

when defined(nimHasUsed): {.used.}

suite "B-Tree test suite":
  test "B-Tree original standard library test":
    proc main() =
      var st = initBTree[string, string]()
      st.add("www.cs.princeton.edu", "abc")
      st.add("www.princeton.edu",    "128.112.128.15")
      st.add("www.yale.edu",         "130.132.143.21")
      st.add("www.simpsons.com",     "209.052.165.60")
      st.add("www.apple.com",        "17.112.152.32")
      st.add("www.amazon.com",       "207.171.182.16")
      st.add("www.ebay.com",         "66.135.192.87")
      st.add("www.cnn.com",          "64.236.16.20")
      st.add("www.google.com",       "216.239.41.99")
      st.add("www.nytimes.com",      "199.239.136.200")
      st.add("www.microsoft.com",    "207.126.99.140")
      st.add("www.dell.com",         "143.166.224.230")
      st.add("www.slashdot.org",     "66.35.250.151")
      st.add("www.espn.com",         "199.181.135.201")
      st.add("www.weather.com",      "63.111.66.11")
      st.add("www.yahoo.com",        "216.109.118.65")

      check:
        st.getOrDefault("www.cs.princeton.edu") == "abc"
        st.getOrDefault("www.harvardsucks.com") == ""
        st.getOrDefault("www.simpsons.com") == "209.052.165.60"
        st.getOrDefault("www.apple.com") == "17.112.152.32"
        st.getOrDefault("www.ebay.com") == "66.135.192.87"
        st.getOrDefault("www.dell.com") == "143.166.224.230"
        st.entries == 16

      when false:
        var b2 = initBTree[string, string]()
        const iters = 10_000
        for i in 1..iters:
          b2.add($i, $(iters - i))
        for i in 1..iters:
          let x = b2.getOrDefault($i)
          if x != $(iters - i):
            echo "got ", x, ", but expected ", iters - i
        echo b2.entries

      when true:
        var b2 = initBTree[int, string]()
        var t2 = initTable[int, string]()
        const iters = 100_000
        for i in 1..iters:
          let x = rand(high(int))
          if not t2.hasKey(x):
            check b2.getOrDefault(x).len == 0
            t2[x] = $x
            b2.add(x, $x)

        check b2.entries == t2.len
        for k, v in t2:
          check $k == v
          check b2.getOrDefault(k) == $k

    main()
