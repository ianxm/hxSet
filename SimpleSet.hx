import haxe.ds.BalancedTree;
using Lambda;

/**
   This is a simple 'set' class.  It supports basic set operations.  It is implemented with a
   balanced tree.  V is the type of the value.
 */
class SimpleSet<V>
{
    public var length(default,null) :Int;
    private var vals :BalancedTree<V,Int>;

    /**
       create an empty set
     */
    public function new()
    {
        vals = new BalancedTree<V,Int>();
        length = 0;
    }

    /**
       add an item to the set if the key doesn't already exist.
       returns true if it was added
     */
    public function add(item :V) :Bool
    {
        if( !vals.exists(item) )
        {
            vals.set(item, 1);
            length++;
            return true;
        }
        return false;
    }

    /**
       remove the item from the set with the given key
       returns true if an item was removed
     */
    public function remove(item :V) :Bool
    {
        if( vals.remove(item) )
        {
            length--;
            return true;
        }
        return false;
    }

    /**
        returns true if the given item is in the set
     */
    inline public function has(item :V) :Bool
    {
        return vals.exists(item);
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
        remove items which are not in the given iterable.
        returns the number of items removed
     */
    public function intersection(otherItems :Iterable<V>) :Int
    {
        var otherSet = new SimpleSet<V>();
        otherSet.union(otherItems);
        var count = 0;
        for( ii in vals.keys() )
            if( !otherSet.has(ii) )
                count += vals.remove(ii) ? 1 : 0;
        length -= count;
        return count;
    }

    /**
        remove items that are in the given iterable.
        return the number of items removed
     */
    public function minus(otherItems :Iterable<V>) :Int
    {
        var count = 0;
        for( ii in otherItems )
            count += vals.remove(ii) ? 1 : 0;
        length -= count;
        return count;
    }

    /**
        check if sets are equal (made up of the same items).
        return true if both sets contain the same items
     */
    public function equals(otherSet :SimpleSet<V>) :Bool
    {
        for( ii in vals.keys() )
            if( !otherSet.has(ii) )
                return false;
        return length == otherSet.length;
    }

    /**
        empty the set
     */
    public function clear()
    {
        vals = new BalancedTree<V,Int>();
        length = 0;
    }

    /**
        iterate over items in the set.  order will be fifo.
     */
    public function iterator()
    {
        return vals.keys();
    }
}
