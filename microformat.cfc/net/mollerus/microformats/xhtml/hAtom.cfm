<cfoutput><div class="hfeed">

	<ul><!-- Categories for the whole feed -->
	<li><a href="#ARGUMENTS.feedCategories[].URL#" rel="tag">ARGUMENTS.feedCategories[].name</a></li>
	</ul>

    <div class="hentry">
        <h3 class="entry-title">#ARGUMENTS.entryTitle#</h3>
        <a href="#ARGUMENTS.permalink#" rel="bookmark">Permalink</a>
        <p>Published:<abbr class="updated published" title="#DateFormat(ARGUMENTS.published, 'yyyy-mm-dd')#">#DateFormat(ARGUMENTS.published, 'mmmm d, yyyy')#</abbr> Updated:<abbr class="updated" title="#DateFormat(ARGUMENTS.updated, 'yyyy-mm-dd')#">#DateFormat(ARGUMENTS.updated, 'mmmm d, yyyy')#</abbr></p>
        <div class="content">
            <p><span class="summary">#ARGUMENTS.summary#</p>
            <p><span class="content">#ARGUMENTS.content#</p>
		</div>
        
		<p>Categories
        <ul><!-- Categories for this entry -->
			<li><a href="#ARGUMENTS.categories[].URL#" rel="tag">ARGUMENTS.categories[].name</a></li>
        </ul></p>

    </div>
</div></cfoutput>