{include file='head.tpl'}

<script src="http://www.google.com/jsapi?key=AIzaSyA5m1Nc8ws2BbmPRwKu5gFradvD_hgq6G0" type="text/javascript"></script>



<div class="post" >
    <div class="copy" >
        <div id="rss_content">Loading...</div>
    </div>
</div>



<script type="text/javascript">
    google.load("feeds", "1");

    // Our callback function, for when a feed is loaded.
    function feedLoaded(result) {
        if (!result.error) 
        {
            // Grab the container we will put the results into
            var container = document.getElementById("rss_content");
            container.innerHTML = '';

            // Loop through the feeds, putting the titles onto the page.
            // Check out the result object for a list of properties returned in each entry.
            // http://code.google.com/apis/ajaxfeeds/documentation/reference.html#JSON
            for (var i = 0; i < result.feed.entries.length; i++)
            {
                var entry = result.feed.entries[i];
                
document.createElement("a")
                var div = document.createElement("div");
                div.appendChild(document.createTextNode( entry.title ));
                div.appendChild(document.createTextNode( entry.link ));
                div.appendChild(document.createTextNode( entry.publishedDate ));
                div.appendChild(document.createTextNode( entry.contentSnippet ));

                container.appendChild(div);
            }
        }
    }

    function OnLoad() {
      // Create a feed instance that will grab Digg's feed.
      var feed = new google.feeds.Feed("http://blog.omegaup.com/rss");

      // Calling load sends the request off.  It requires a callback function.
      feed.load(feedLoaded);
    }

    google.setOnLoadCallback(OnLoad);
</script>

​
{include file='footer.tpl'}