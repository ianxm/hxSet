using Lambda;

/**
   This is a simple 'set' class.  It supports basic set operations.  
   It is implemented with a list.
 */
class Set<T>
{
    private var vals :List<T>;

    /**
        create an empty set
     */
    public function new()
    {
        vals = new List<T>();
    }

    /**
        add an item to the set
     */
    public function add(item :T, ?cmp :T->T->Bool)
    {
        if( !vals.has(item, cmp) )
            vals.add(item);
    }

    /**
        returns true if the given item is in the set
     */
    public function has(item :T, ?cmp :T->T->Bool)
    {
        return( vals.has(item, cmp) );
    }

    /**
        add the items from the given iterable to the set
     */
    public function union(otherItems :Iterable<T>, ?cmp :T->T->Bool)
    {
        for( ii in otherItems )
            add(ii, cmp);
    }

    /**
        remove items which are not in the given iterable
     */
    public function intersection(otherItems :Iterable<T>, ?cmp :T->T->Bool)
    {
        for( ii in vals )
            if( !otherItems.has(ii, cmp) )
                vals.remove(ii);
    }

    /**
        remove items in given iterable
     */
    public function minus(otherItems :Iterable<T>, ?cmp :T->T->Bool)
    {
        for( ii in vals )
            if( otherItems.has(ii, cmp) )
                vals.remove(ii);
    }

    /**
        empty the set
     */
    public function clear()
    {
        vals.clear();
    }

    /**
        iterate over items in the set
     */
    public function iterator()
    {
        return vals.iterator();
    }
}
