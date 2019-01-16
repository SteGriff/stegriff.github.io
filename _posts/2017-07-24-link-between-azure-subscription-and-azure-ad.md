# Link between Azure subscription and Azure AD

![Azure Subscription to AD Hierarchy](./posts/link-between-azure-subscription-and-azure-ad/azure-hierarchy-small.png)

I wanted to improve on a diagram I found in the [docs for Azure RBAC][rbac] which provides a really clear illustration of how Azure administrative components are connected. You can see my version here/above, or click through for a [larger version][larger]. The original was a bit hidden away in an unexpected place on the MS site and it deserves more of a surface for discovery.

[rbac]: https://docs.microsoft.com/en-us/azure/active-directory/role-based-access-control-what-is
[larger]: ./posts/link-between-azure-subscription-and-azure-ad/azure-hierarchy.png

## Key points

The rules to take away from this are:

 * Each **subscription** in Azure belongs to only **one directory** (But each directory can control access for more than one subscription.)
 * Each **resource group** belongs to only **one subscription**
 * Each **resource** belongs to only one **resource group**

