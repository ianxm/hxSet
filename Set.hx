import haxe.ds.GenericStack;
using Lambda;

/**
   This is a simple 'set' class.  It supports basic set operations.  
   It is implemented with a list.
 */
class Set<T>
{
    public var length(default,null) :Int;
    private var vals :GenericStack<T>;

    /**
       create an empty set
     */
    public function new()
    {
        vals = new GenericStack<T>();
        length = 0;
    }

    /**
       add an item to the set.
       returns true if it was added
     */
    public function add(item :T, ?cmp :T->T->Bool) :Bool
    {
        if( !has(item, cmp) )
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
        return( (cmp==null) ? vals.has(item) : vals.exists( function(a) return cmp(a,item) ) );
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
            if( !((cmp==null) && otherItems.has(ii) || cmp!=null && otherItems.exists( function(a) return cmp(a,ii) )) )
                count += vals.remove(ii) ? 1 : 0;
        length -= count;
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
            if( (cmp==null && otherItems.has(ii)) || cmp!=null && otherItems.exists( function(a) return cmp(a,ii) ) )
                count += vals.remove(ii) ? 1 : 0;
        length -= count;
        return count;
    }

    /**
        check if sets are equal (made up of the same items).  pass in a cmp function to override item comparison. O(n^2).
        return true if both sets contain the same (or equivalent if cmp is provided) items
     */
    public function equals(otherSet :Set<T>, ?cmp :T->T->Bool) :Bool
    {
        if( cmp == null )
            cmp = function(a,b){ return a==b; }
        for( ii in vals )
        {
            var found = false;
            for( jj in otherSet.iterator() )
                if( cmp(ii, jj) )
                {
                    found = true;
                    continue;
                }
            if( !found )
                return false;
        }
        return length == otherSet.length;
    }

    /**
        empty the set
     */
    public function clear()
    {
        vals = new GenericStack<T>();
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
