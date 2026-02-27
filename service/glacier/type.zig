pub const Type = enum {
    amazon_customer_by_email,
    canonical_user,
    group,

    pub const json_field_names = .{
        .amazon_customer_by_email = "AmazonCustomerByEmail",
        .canonical_user = "CanonicalUser",
        .group = "Group",
    };
};
