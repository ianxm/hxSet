class TestSimpleSet extends haxe.unit.TestCase
{
    public function testSimpleHas()
    {
        var set = new SimpleSet<Int>();
        assertEquals(true, set.add(1));
        assertEquals(true, set.add(2));
        assertEquals(true, set.add(3));
        assertTrue(set.has(1));
        assertTrue(set.has(2));
        assertTrue(set.has(3));
        assertFalse(set.has(4));
        assertFalse(set.has(101));
    }

    public function testSimpleLength()
    {
        var set = new SimpleSet<Int>();
        assertEquals(0, set.length);
        assertEquals(true, set.add(1));
        assertEquals(1, set.length);
        assertEquals(true, set.add(2));
        assertEquals(2, set.length);
        assertEquals(true, set.add(3));
        assertEquals(3, set.length);
        assertEquals(false, set.add(2)); // didn't get added
        assertEquals(3, set.length);
    }

    public function testSimpleString()
    {
        var set = new SimpleSet<String>();
        set.add("one");
        set.add("two");
        set.add("three");
        assertTrue(set.has("one"));
        assertTrue(set.has("two"));
        assertTrue(set.has("three"));
        assertFalse(set.has("four"));
    }

    public function testSimpleRemove()
    {
        var set = new SimpleSet<String>();
        set.add("112");
        set.add("122");
        set.add("113");
        assertEquals(3, set.length);
        assertTrue(set.remove("112"));
        assertTrue(set.remove("113"));
        assertFalse(set.remove("555"));
        assertEquals(1, set.length);
        assertTrue(set.has("122"));
    }

    public function testSimpleClear()
    {
        var set = new SimpleSet<Int>();
        set.add(1);
        set.add(2);
        assertTrue(set.has(1));
        assertTrue(set.has(2));
        set.clear();
        assertFalse(set.has(1));
        assertFalse(set.has(2));
    }

    public function testSimpleUnion()
    {
        var set = new SimpleSet<Int>();
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

    public function testSimpleIntersection()
    {
        var set = new SimpleSet<Int>();
        set.add(1);
        set.add(2);
        assertTrue(set.has(1));
        assertTrue(set.has(2));
        assertEquals(1, set.intersection([2,3,4]));
        assertFalse(set.has(1));
        assertTrue(set.has(2));
        assertFalse(set.has(3));
    }

    public function testSimpleMinus()
    {
        var set = new SimpleSet<Int>();
        set.add(1);
        set.add(2);
        set.add(3);
        assertEquals(2, set.minus([1,3,4]));
        assertFalse(set.has(1));
        assertTrue(set.has(2));
        assertFalse(set.has(3));
        assertFalse(set.has(4));
    }

    public function testSimpleIter()
    {
        var set = new SimpleSet<Int>();
        set.add(1);
        set.add(2);
        set.add(3);
        var iter = set.iterator();
        assertEquals(1, iter.next());
        assertEquals(2, iter.next());
        assertEquals(3, iter.next());
    }

    public function testSimpleEquals()
    {
        var set1 = new SimpleSet<Int>();
        set1.add(1);
        set1.add(2);

        var set2 = new SimpleSet<Int>();
        set2.add(2);
        set2.add(1);
        assertTrue(set1.equals(set2));

        var set3 = new SimpleSet<Int>();
        set3.add(1);
        set3.add(3);
        assertFalse(set1.equals(set3));

        var set4 = new SimpleSet<Int>();
        set4.add(1);
        set4.add(2);
        set4.add(3);
        assertFalse(set1.equals(set4));
    }

    public function testSimpleEqualsString()
    {
        var set1 = new SimpleSet<String>();
        set1.add("car");
        set1.add("boat");

        var set2 = new SimpleSet<String>();
        set2.add("boat");
        set2.add("car");
        assertTrue(set1.equals(set2));

        var set3 = new SimpleSet<String>();
        set3.add("car");
        set3.add("dog");
        assertFalse(set1.equals(set3));
    }
}
