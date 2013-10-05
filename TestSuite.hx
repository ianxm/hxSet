class TestSuite
{
    static function main()
    {
        var r = new haxe.unit.TestRunner();
        r.add(new TestSimpleSet());
        r.add(new TestComplexSet());
        r.run();
    }
}
