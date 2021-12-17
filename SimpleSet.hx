import haxe.ds.BalancedTree;
using Lambda;

/**
   This is a simple 'set' class.  It supports basic set operations.  It is implemented with a
   balanced tree.  V is the type of the value.
*/
class SimpleSet<V> extends Set<V,V>
{
    /**
       create an empty set
    */
    public function new()
    {
        super();
        getKey = (val) -> val;
    }

    /**
       add an item to the set if the key doesn't already exist.
       returns true if it was added
    */
    override public function add(item :V) :Bool
    {
        if( !vals.exists(item) )
            {
                vals.set(item, null);
                length++;
                return true;
            }
        return false;
    }

    /**
       doesn't make much sense here since we just store values as keys, but this returns the key if it exists else null
    */
    override public function get(key :V) :V
    {
        return if( vals.has(key) ){
            return key;
        } else {
            return null;
        }
    }

    override private function makeOtherSet() :Set<V,V> {
        return new SimpleSet<V>();
    }

    /**
       check if sets are equal (made up of the same items).
       return true if both sets contain the same items
    */
    override public function equals(otherSet :Set<V,V>) :Bool
    {
        for( ii in vals.keys() )
            if( !otherSet.has(ii) )
                return false;
        return length == otherSet.length;
    }

    /**
       iterate over items in the set.  order will be filo.
    */
    override public function iterator()
    {
        return vals.keys();
    }
}
