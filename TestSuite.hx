class TestSuite
{
    static function main()
    {
        var r = new haxe.unit.TestRunner();
        r.add(new TestSet());
        r.add(new TestSimpleSet());
        r.run();
    }
}
