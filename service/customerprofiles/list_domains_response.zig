const ListDomainItem = @import("list_domain_item.zig").ListDomainItem;

pub const ListDomainsResponse = struct {
    /// The list of ListDomains instances.
    items: ?[]const ListDomainItem = null,

    /// The pagination token from the previous ListDomains API call.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "Items",
        .next_token = "NextToken",
    };
};
