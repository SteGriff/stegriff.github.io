# Umbraco 4 navigation menu with hidden items

Look, I don't choose to work with Umbraco 4, but sometimes you're maintaining a legacy system for a client and needs must.

A lot of older Umbraco systems just use XSLT for macros like this, but this project is heavy on .Net user controls and we use the old Umbraco NodeFactory API to get data.

I found it hard to make a menu which gave me `umbracoNaviHide` capabilities, so here are my finished snippets for your benefit:

## First , a singleton for accessing the CurrentSitemapNode

    private SiteMapNode _currentSitemapNode;
    public SiteMapNode CurrentSitemapNode
    {
        get
        {
            if (_currentSitemapNode == null)
            {
                _currentSitemapNode = SiteMap.Providers["UmbracoSiteMapProvider"].CurrentNode;
            }
            return _currentSitemapNode;
        }
    }

## A helper function for getting the value of a property

This fixes some oddities around umbraco yes/no fields

	public T PropertyValue<T>(Node umbracoNode, string propertyName)
	{
		//Get the umbraco property value as an object
		object originalValue = umbracoNode.GetProperty(propertyName).Value;

		//Use a special conversion if it is a bool
		if (typeof(T) == typeof(bool))
		{
			//Have to use .Equals here (not ==) because "1" is string and originalValue is object
			originalValue = (originalValue.Equals("1"));
		}

		//Otherwise use generic conversion to cast it to T
		return (T)Convert.ChangeType(originalValue, typeof(T));
	}
	
## The function which gets the actual navigation items

	private SiteMapNodeCollection GetNavigationItems()
	{
		//For the root of the navigation, you can either use the current parentNode:
		var parentNode = CurrentSitemapNode.ParentNode;
		
		//...Or get a particlar node by id:
		/*
		const string particularNodeId = "2001";
		var parentNode = SiteMap.Providers["UmbracoSiteMapProvider"].FindSiteMapNodeFromKey(particularNodeId);
		*/
		
		//If you don't care about umbracoNaviHide:
		/*
		return parentNode.ChildNodes;
		*/
		
		//If you do:
		SiteMapNodeCollection children = new SiteMapNodeCollection();
		foreach (SiteMapNode node in parentNode.ChildNodes)
		{
			//Get the umbraco node using the ID (key) of the SiteMapNode
			int nodeId = Int32.Parse(node.Key);
			var umbracoNode = new Node(nodeId);
			
			//Use the helper function to get boolean property value
			bool hidden = PropertyValue<bool>(umbracoNode, "umbracoNaviHide");
			if (!hidden)
			{
				children.Add(node);
			}
		}

		return children;
	}
	
Now that you have a source of NavigationItems, you need to provide them to the front end. I use another singleton for this so that it doesn't get recalculated in program code unnecessarily:

	private SiteMapNodeCollection _navigationItems;
	public SiteMapNodeCollection NavigationItems
	{
		get
		{
			if (_navigationItems == null)
			{
				_navigationItems = GetNavigationItems();
			}
			return _navigationItems;
		}
	}

## How do you render the menu items?

I pass them into an `asp:ListView` in the frontend which uses the aforementioned singleton for a data source:

	<ul class="account-sidenav">
		<asp:ListView runat="server" ID="NavigationList" ItemPlaceholderID="navItem" DataSource="<%# NavigationItems %>">
			<LayoutTemplate>
				<asp:placeholder runat="server" ID="navItem" />
			</LayoutTemplate>
			<ItemTemplate>
				<li>
					<a href="<%# ((SiteMapNode)Container.DataItem).Url %>">
						<%# ((SiteMapNode)Container.DataItem).Title %>
					</a>
				</li>
			</ItemTemplate>
		</asp:ListView>
	</ul>

## Add 'Active' link highlighting

That's enough to make it work. If you want to highlight the current page in the menu, you can tweak the inner link to this:
                
	<a href="<%# ((SiteMapNode)Container.DataItem).Url %>" class="<%# AddActiveClass((SiteMapNode)Container.DataItem) %>">
		<%# ((SiteMapNode)Container.DataItem).Title %>
	</a>

And add this function in the code behind:

    public string AddActiveClass(SiteMapNode node)
    {
        return CurrentSitemapNode.Title == node.Title
            ? "active"
            : "";
    }
	
Hope this helps you!