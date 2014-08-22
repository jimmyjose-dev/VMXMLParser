VMXMLParser
=====================

NSXMLParser wrapper in Swift
----------------------------------
**Features:**
>  1) Closure based 
>  
>  2) Get array of dictionaries as response 
>  
>  3) Unicode support




Sample code
-----------

    var url:String="http://www.varshylmobile.com/projects-1/iOS/sample1.xml"
    VMXMLParser.parseXMLForURLString(url, completionHandler: { (tags, error) -> Void in
            if(error != nil){
                println(error)
            }else{
                println(tags!)
            }
        })


----------

Sample response
---------------

> (
>         {
>         description = "Does this parser work ?";
>         id = 1;
>         location = India;
>         name = "Jimmy Jose the swifter";
>     },
>         {
>         description = "Running out of words now";
>         id = 2;
>         location = USA;
>         name = "Jimmy Jose the objector";
>     },
>         {
>         description = "Jimmy Jose Varshyl Mobile";
>         id = 3;
>         location = USA;
>         name = "Varshyl Mobile";
>     },
>         {
>         description = "Need to have better example next time";
>         id = 4;
>         location = Delhi;
>         name = Varshyl;
>     },
>         {
>         description = "I should have downloaded some sample xml file";
>         id = 5;
>         location = Australia;
>         name = "Varshyl Tech";
>     } )


Contact Us
---------------

Have any questions or suggestions feel free to write at jimmy@varshyl.com (Jimmy Jose)
http://www.varshylmobile.com/


