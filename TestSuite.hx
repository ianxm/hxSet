import TestSet;

class TestSuite
{
    static function main()
    {
        var r = new haxe.unit.TestRunner();
        r.add(new TestSet());
        r.run();
    }
}
