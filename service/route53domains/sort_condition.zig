const ListDomainsAttributeName = @import("list_domains_attribute_name.zig").ListDomainsAttributeName;
const SortOrder = @import("sort_order.zig").SortOrder;

/// Information for sorting a list of domains.
pub const SortCondition = struct {
    /// Field to be used for sorting the list of domains. It can be either the name
    /// or the
    /// expiration for a domain. Note that if `filterCondition` is used in the same
    /// [ListDomains](https://docs.aws.amazon.com/Route53/latest/APIReference/API_domains__ListDomains.html)
    /// call, the field used for sorting has to be the same as the field used for
    /// filtering.
    name: ListDomainsAttributeName,

    /// The sort order for a list of domains. Either ascending (ASC) or descending
    /// (DES).
    sort_order: SortOrder,

    pub const json_field_names = .{
        .name = "Name",
        .sort_order = "SortOrder",
    };
};
