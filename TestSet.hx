class TestSet extends haxe.unit.TestCase
{
    public function testHas()
    {
        var set = new Set();
        assertEquals(set.add(1), true);
        assertEquals(set.add(2), true);
        assertEquals(set.add(3), true);
        assertTrue(set.has(1));
        assertTrue(set.has(2));
        assertTrue(set.has(3));
        assertFalse(set.has(4));
        assertFalse(set.has(101));
    }

    public function testLength()
    {
        var set = new Set();
        assertEquals(set.length, 0);
        assertEquals(set.add(1), true);
        assertEquals(set.length, 1);
        assertEquals(set.add(2), true);
        assertEquals(set.length, 2);
        assertEquals(set.add(3), true);
        assertEquals(set.length, 3);
        assertEquals(set.add(2), false); // didn't get added
        assertEquals(set.length, 3);
    }

    public function testString()
    {
        var set = new Set();
        set.add("one");
        set.add("two");
        set.add("three");
        assertTrue(set.has("one"));
        assertTrue(set.has("two"));
        assertTrue(set.has("three"));
        assertFalse(set.has("four"));
    }

    public function testRemove()
    {
        var set = new Set();
        set.add("112");
        set.add("122");
        set.add("113");
        assertEquals(set.length, 3);
        assertEquals(set.remove( function(ii) return StringTools.startsWith(ii, "11") ), 2);
        assertEquals(set.length, 1);
        assertTrue(set.has("122"));
    }

    public function testClear()
    {
        var set = new Set();
        set.add(1);
        set.add(2);
        assertTrue(set.has(1));
        assertTrue(set.has(2));
        set.clear();
        assertFalse(set.has(1));
        assertFalse(set.has(2));
    }

    public function testUnion()
    {
        var set = new Set();
        set.add(1);
        set.add(2);
        assertFalse(set.has(3));
        assertFalse(set.has(4));
        assertEquals(set.union([3,4]), 2);
        assertTrue(set.has(1));
        assertTrue(set.has(2));
        assertTrue(set.has(3));
        assertTrue(set.has(4));
    }

    public function testIntersection()
    {
        var set = new Set();
        set.add(1);
        set.add(2);
        assertTrue(set.has(1));
        assertTrue(set.has(2));
        assertEquals(set.intersection([2,3,4]), 1);
        assertFalse(set.has(1));
        assertTrue(set.has(2));
        assertFalse(set.has(3));
    }

    public function testMinus()
    {
        var set = new Set();
        set.add(1);
        set.add(2);
        set.add(3);
        assertEquals(set.minus([1,3,4]), 2);
        assertFalse(set.has(1));
        assertTrue(set.has(2));
        assertFalse(set.has(3));
        assertFalse(set.has(4));
    }

    public function testIter()
    {
        var set = new Set();
        set.add(1);
        set.add(2);
        set.add(3);
        var iter = set.iterator();
        assertEquals(iter.next(), 3);
        assertEquals(iter.next(), 2);
        assertEquals(iter.next(), 1);
    }

    public function testEquals()
    {
        var set1 = new Set<Int>();
        set1.add(1);
        set1.add(2);

        var set2 = new Set<Int>();
        set2.add(2);
        set2.add(1);
        assertTrue(set1.equals(set2));

        var set3 = new Set<Int>();
        set3.add(1);
        set3.add(3);
        assertFalse(set1.equals(set3));

        var set4 = new Set<Int>();
        set4.add(1);
        set4.add(2);
        set4.add(3);
        assertFalse(set1.equals(set4));
    }

    public function testEqualsString()
    {
        var set1 = new Set<String>();
        set1.add("car");
        set1.add("boat");

        var set2 = new Set<String>();
        set2.add("boat");
        set2.add("car");
        assertTrue(set1.equals(set2));

        var set3 = new Set<String>();
        set3.add("car");
        set3.add("dog");
        assertFalse(set1.equals(set3));
    }

    public function testEqualsCmp()
    {
        var set1 = new Set<Obj>();
        set1.add({f1: 1, f2: "car"});
        set1.add({f1: 2, f2: "dog"});

        var set2 = new Set<Obj>();
        set2.add({f1: 2, f2: "dog"});
        set2.add({f1: 1, f2: "car"});
        assertFalse(set1.equals(set2));
        assertTrue(set1.equals(set2, function(a,b) return a.f1==b.f1 && a.f2==b.f2 ));

        var set3 = new Set<Obj>();
        set3.add({f1: 1, f2: "car"});
        set3.add({f1: 3, f2: "dog"});
        assertFalse(set1.equals(set3, function(a,b) return a.f1==b.f1 ));
        assertTrue(set1.equals(set3, function(a,b) return a.f2==b.f2 ));
        assertFalse(set1.equals(set3));

        var set4 = new Set<Obj>();
        set4.add({f1: 1, f2: "car"});
        set4.add({f1: 2, f2: "boat"});
        assertTrue(set1.equals(set4, function(a,b) return a.f1==b.f1 ));
        assertFalse(set1.equals(set4));
    }
}

typedef Obj = {
    var f1 :Int;
    var f2 :String;
}
