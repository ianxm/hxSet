import haxe.FastList;
using Lambda;

/**
   This is a simple 'set' class.  It supports basic set operations.  
   It is implemented with a list.
 */
class Set<T>
{
    public var length(default,null) :Int;
    private var vals :FastList<T>;

    /**
       create an empty set
     */
    public function new()
    {
        vals = new FastList<T>();
        length = 0;
    }

    /**
       add an item to the set.
       returns true if it was added
     */
    public function add(item :T, ?cmp :T->T->Bool) :Bool
    {
        if( !vals.has(item, cmp) )
        {
            vals.add(item);
            length++;
            return true;
        }
        return false;
    }

    /**
       remove items from the set that are selected by the given predicate
       returns the number of items removed
     */
    public function remove(pred :T->Bool) :Int
    {
        var count = 0;
        for( ii in vals )
            if( pred(ii) )
                count += vals.remove(ii) ? 1 : 0;
        length -= count;
        return count;
    }

    /**
        returns true if the given item is in the set
     */
    public function has(item :T, ?cmp :T->T->Bool)
    {
        return( vals.has(item, cmp) );
    }

    /**
        returns true if the set is empty
     */
    public function isEmpty()
    {
        return( vals.isEmpty() );
    }

    /**
        add the items from the given iterable to the set
        returns the number of items added
     */
    public function union(otherItems :Iterable<T>, ?cmp :T->T->Bool) :Int
    {
        var count = 0;
        for( ii in otherItems )
            count += add(ii, cmp) ? 1 : 0;
        return count;
    }

    /**
        remove items which are not in the given iterable
        returns the number of items removed
     */
    public function intersection(otherItems :Iterable<T>, ?cmp :T->T->Bool) :Int
    {
        var count = 0;
        for( ii in vals )
            if( !otherItems.has(ii, cmp) )
                count += vals.remove(ii) ? 1 : 0;
        length += count;
        return count;
    }

    /**
        remove items what are in given iterable
        return the number of items removed
     */
    public function minus(otherItems :Iterable<T>, ?cmp :T->T->Bool) :Int
    {
        var count = 0;
        for( ii in vals )
            if( otherItems.has(ii, cmp) )
                count += vals.remove(ii) ? 1 : 0;
        length += count;
        return count;
    }

    /**
        empty the set
     */
    public function clear()
    {
        vals = new FastList<T>();
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
