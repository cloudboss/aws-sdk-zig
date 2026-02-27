pub const IdentityType = enum {
    email_address,
    domain,
    managed_domain,

    pub const json_field_names = .{
        .email_address = "EMAIL_ADDRESS",
        .domain = "DOMAIN",
        .managed_domain = "MANAGED_DOMAIN",
    };
};
