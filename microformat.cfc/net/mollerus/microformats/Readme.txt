LICENSE
----------------------------------------------------------------
Copyright 2007 Tom Mollerus

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
   

AUTHOR
----------------------------------------------------------------
This software was written by Tom Mollerus. If you like this software and want to thank him, feel free to purchase a gift from his Amazon wishlist (http://www.amazon.com/gp/registry/wishlist/1EO6W8N5KBFBG ).


INSTALLATION
----------------------------------------------------------------
Copy the CFCs, the xhtml folder, and the xslt folder to a location where the CFCs can be accessed by ColdFusion as components. It is important that the xhtml and xslt folders be in the same folder as the CFCs.  Then call the components from any Coldfusion page. To test the components, copy the test.*.cfm files to your webroot.


CHANGELOG
----------------------------------------------------------------
Version 0.1  May 15, 2007
* Have getFeed method in microformats.cfc as a proxy for cfhttp calls
* Have getMicroformats method in microformats.cfc to parse all microformat instances in a string
* Have getXML method in microformats.cfc to parse through arrays of XML for XSLT transforms
* Have Transform method in microformats.cfc to handle all XSLT transformations
* Have IsValidKey function in microformats.cfc to gracefully handle empty/invalid arguments
* Have create() and h*Proxy() functions for hAtom, hCalendar, hCard, and hReview