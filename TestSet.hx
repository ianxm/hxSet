class TestSet extends haxe.unit.TestCase
{
    public function testHas()
    {
        var set = new Set<Int,Int>();
        set.getKey = function(val) return val;
        assertEquals(true, set.add(1));
        assertEquals(true, set.add(2));
        assertEquals(true, set.add(3));
        assertTrue(set.has(1));
        assertTrue(set.has(2));
        assertTrue(set.has(3));
        assertFalse(set.has(4));
        assertFalse(set.has(101));
    }

    public function testLength()
    {
        var set = new Set<Int,Int>();
        set.getKey = function(val) return val;
        assertEquals(0, set.length);
        assertTrue(set.add(1));
        assertEquals(1, set.length);
        assertTrue(set.add(2));
        assertEquals(2, set.length);
        assertTrue(set.add(3));
        assertEquals(3, set.length);
        assertFalse(set.add(2)); // didn't get added
        assertEquals(3, set.length);
    }

    public function testString()
    {
        var set = new Set<String,String>();
        set.getKey = function(val) return val;
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
        var set = new Set<String,String>();
        set.getKey = function(val) return val;
        set.add("112");
        set.add("122");
        set.add("113");
        assertEquals(3, set.length);
        assertEquals(true, set.remove( "113" ));
        assertEquals(2, set.length);
        assertTrue(set.has("122"));
        assertFalse(set.has("113"));
    }

    public function testClear()
    {
        var set = new Set<Int,Int>();
        set.getKey = function(val) return val;
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
        var set = new Set<Int,Int>();
        set.getKey = function(val) return val;
        set.add(1);
        set.add(2);
        assertFalse(set.has(3));
        assertFalse(set.has(4));
        assertEquals(2, set.union([3,4]));
        assertTrue(set.has(1));
        assertTrue(set.has(2));
        assertTrue(set.has(3));
        assertTrue(set.has(4));
    }

    public function testIntersection()
    {
        var set = new Set<Int,Int>();
        set.getKey = function(val) return val;
        set.add(1);
        set.add(2);
        assertTrue(set.has(1));
        assertTrue(set.has(2));
        assertEquals(1, set.intersection([2,3,4]));
        assertFalse(set.has(1));
        assertTrue(set.has(2));
        assertFalse(set.has(3));
    }

    public function testMinus()
    {
        var set = new Set<Int,Int>();
        set.getKey = function(val) return val;
        set.add(1);
        set.add(2);
        set.add(3);
        assertEquals(2, set.minus([1,3,4]));
        assertFalse(set.has(1));
        assertTrue(set.has(2));
        assertFalse(set.has(3));
        assertFalse(set.has(4));
    }

    public function testIter()
    {
        var set = new Set<Int,Int>();
        set.getKey = function(val) return val;
        set.add(1);
        set.add(2);
        set.add(3);
        var iter = set.iterator();
        assertEquals(1, iter.next());
        assertEquals(2, iter.next());
        assertEquals(3, iter.next());
    }

    public function testEquals()
    {
        var set1 = new Set<Int,Int>();
        set1.getKey = function(val) return val;
        set1.add(1);
        set1.add(2);

        var set2 = new Set<Int,Int>();
        set2.getKey = function(val) return val;
        set2.add(2);
        set2.add(1);
        assertTrue(set1.equals(set2));

        var set3 = new Set<Int,Int>();
        set3.getKey = function(val) return val;
        set3.add(1);
        set3.add(3);
        assertFalse(set1.equals(set3));

        var set4 = new Set<Int,Int>();
        set4.getKey = function(val) return val;
        set4.add(1);
        set4.add(2);
        set4.add(3);
        assertFalse(set1.equals(set4));
    }

    public function testEqualsString()
    {
        var set1 = new Set<String,String>();
        set1.getKey = function(val) return val;
        set1.add("car");
        set1.add("boat");

        var set2 = new Set<String,String>();
        set2.getKey = function(val) return val;
        set2.add("boat");
        set2.add("car");
        assertTrue(set1.equals(set2));

        var set3 = new Set<String,String>();
        set3.getKey = function(val) return val;
        set3.add("car");
        set3.add("dog");
        assertFalse(set1.equals(set3));
    }

    public function testAddCmp()
    {
        var set1 = new Set<Int,Obj>();
        set1.getKey = function(val) return val.f1;
        set1.add({f1: 1, f2: "car"});
        set1.add({f1: 2, f2: "dog"});
        set1.add({f1: 3, f2: "dog"});
        set1.add({f1: 3, f2: "cat"});
        assertEquals(3, set1.length);

        var set1b = new Set<Int,Obj>();
        set1b.getKey = function(val) return val.f1;
        set1b.add({f1: 1, f2: "car"});
        set1b.add({f1: 2, f2: "dog"});
        set1b.add({f1: 3, f2: "dog"});
        assertTrue(set1.equals(set1b));
        
        var set2 = new Set<String,Obj>();
        set2.getKey = function(val) return val.f2;
        set2.add({f1: 1, f2: "car"});
        set2.add({f1: 2, f2: "dog"});
        set2.add({f1: 3, f2: "dog"});
        set2.add({f1: 3, f2: "cat"});
        assertEquals(3, set2.length);

        var set2b = new Set<String,Obj>();
        set2b.getKey = function(val) return val.f2;
        set2b.add({f1: 1, f2: "car"});
        set2b.add({f1: 2, f2: "dog"});
        set2b.add({f1: 3, f2: "cat"});
        assertTrue(set1.equals(set1b));
    }

    public function testHasCmp()
    {
        var set1 = new Set<String,Obj>();
        set1.getKey = function(val) return val.f2;
        var obj1 = {f1: 1, f2: "car"};
        set1.add(obj1);
        set1.add({f1: 2, f2: "dog"});
        set1.add({f1: 3, f2: "dog"});
        set1.add({f1: 3, f2: "cat"});
        assertTrue(set1.has("car"));
        assertTrue(set1.has(obj1));
        assertFalse(set1.has("mouse"));
    }

    public function testRemoveCmp()
    {
        var set1 = new Set<String,Obj>();
        set1.getKey = function(val) return val.f2;
        var obj1 = {f1: 1, f2: "car"};
        set1.add(obj1);
        set1.add({f1: 2, f2: "dog"});
        assertTrue(set1.has("car"));
        assertTrue(set1.has(obj1));
        assertTrue(set1.has("dog"));
        set1.remove("dog");
        assertFalse(set1.has("dog"));
        assertTrue(set1.has("car"));
        set1.remove(obj1);
        assertFalse(set1.has("car"));
        assertFalse(set1.has(obj1));
        assertEquals(0, set1.length);
    }

    public function testEqualsCmp()
    {
        var set1 = new Set<Int,Obj>();
        set1.getKey = function(val) return val.f1;
        set1.add({f1: 1, f2: "car"});
        set1.add({f1: 2, f2: "dog"});

        var set2 = new Set<Int,Obj>();
        set2.getKey = function(val) return val.f1;
        set2.add({f1: 2, f2: "dog"});
        assertFalse(set1.equals(set2));
        set2.add({f1: 1, f2: "car"});
        assertTrue(set1.equals(set2));
    }
}

typedef Obj = {
    var f1 :Int;
    var f2 :String;
}
