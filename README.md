VMXMLParser
=====================

NSXMLParser wrapper in Swift
----------------------------------
**Features:**
>  1) Closure based 
>  
>  2) Response as array of dictionaries 
>  
>  3) Unicode support




Sample code
-----------

    var url:String="http://www.varshylmobile.com/projects-1/iOS/sample1.xml"
        VMXMLParser.initParserWithURLString(url, completionHandler: {
            (tags, error) -> Void in
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

----------
## License

The MIT License (MIT)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

