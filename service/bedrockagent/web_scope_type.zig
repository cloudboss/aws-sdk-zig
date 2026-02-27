pub const WebScopeType = enum {
    host_only,
    subdomains,

    pub const json_field_names = .{
        .host_only = "HOST_ONLY",
        .subdomains = "SUBDOMAINS",
    };
};
