const ListDomainItem = @import("list_domain_item.zig").ListDomainItem;

pub const ListDomainsResponse = struct {
    /// The list of ListDomains instances.
    items: ?[]const ListDomainItem,

    /// The pagination token from the previous ListDomains API call.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .items = "Items",
        .next_token = "NextToken",
    };
};
