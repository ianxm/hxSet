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
        assertEquals(iter.next(), 1);
        assertEquals(iter.next(), 2);
        assertEquals(iter.next(), 3);
    }
}
