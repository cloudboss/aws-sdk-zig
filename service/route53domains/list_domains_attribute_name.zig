pub const ListDomainsAttributeName = enum {
    domain_name,
    expiry,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .expiry = "Expiry",
    };
};
