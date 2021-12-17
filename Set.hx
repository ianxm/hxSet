import haxe.ds.BalancedTree;
import haxe.EnumTools;
using Lambda;

/**
   This is a 'set' class.  It supports basic set operations.  It is implemented with a balanced tree.  K is the type of
   the key, V is the type of the value.  You must provide 'getKey' which generates a key from an object.
 */
class Set<K,V>
{
    public var length(default,null) :Int;
    private var vals :BalancedTree<K,V>;

    /**
       override this to use the field of an object as the key. By default return the value as the key if K and V are the
       same type.
     */
    
    public dynamic function getKey(val :V) :K
    {
        throw "getKey must be overridden";
    }

    /**
       create an empty set
     */
    public function new()
    {
        vals = new BalancedTree<K,V>();
        length = 0;
    }

    /**
       add an item to the set if the key doesn't already exist.
       returns true if it was added
     */
    public function add(item :V) :Bool
    {
        var key = getKey(item);
        if( !vals.exists(key) )
        {
            vals.set(key, item);
            length++;
            return true;
        }
        return false;
    }

    /**
       remove the item from the set with the given key
       returns true if an item was removed
     */
    public function remove(?item :V, ?key :K) :Bool
    {
        if( item != null )
            key = getKey(item);
        if( vals.remove(key) )
        {
            length--;
            return true;
        }
        return false;
    }

    /**
        returns true if the given item is in the set
     */
    inline public function has(?item :V, ?key :K) :Bool
    {
        return vals.exists((key!=null) ? key : getKey(item));
    }

    /**
        returns the value for the given key
     */
    public function get(key :K) :V
    {
        return vals.get(key);
    }

    /**
        returns true if the set is empty
     */
    inline public function isEmpty()
    {
        return( length==0 );
    }

    /**
        add the items from the given iterable to the set
        returns the number of items added
     */
    public function union(otherItems :Iterable<V>) :Int
    {
        var count = 0;
        for( ii in otherItems )
            count += add(ii) ? 1 : 0;
        return count;
    }

    /**
        remove items which are not in the given iterable
        returns the number of items removed
     */
    public function intersection(otherItems :Iterable<V>) :Int
    {
        var otherSet = makeOtherSet();
        otherSet.getKey = getKey;
        otherSet.union(otherItems);
        var count = 0;
        for( ii in vals.keys() )
            if( !otherSet.has(ii) )
                count += vals.remove(ii) ? 1 : 0;
        length -= count;
        return count;
    }

    /**
       make a Set that's like this one
     */
    private function makeOtherSet() :Set<K,V> {
        return new Set<K,V>();
    }

    /**
        remove items that are in the given iterable
        return the number of items removed
     */
    public function minus(otherItems :Iterable<V>) :Int
    {
        var count = 0;
        for( ii in otherItems )
            count += vals.remove(getKey(ii)) ? 1 : 0;
        length -= count;
        return count;
    }

    /**
        check if sets are equal (made up of the same items).  pass in a cmp function to override item comparison. O(n^2).
        return true if both sets contain the same (or equivalent if cmp is provided) items
     */
    public function equals(otherSet :Set<K,V>) :Bool
    {
        for( ii in vals )
            if( !otherSet.has(ii) )
                return false;
        return length == otherSet.length;
    }

    /**
        empty the set
     */
    public function clear()
    {
        vals = new BalancedTree<K,V>();
        length = 0;
    }

    /**
        iterate over items in the set.  order will be filo.
     */
    public function iterator()
    {
        return vals.iterator();
    }
}
