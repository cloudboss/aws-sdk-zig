pub const TenantIsolationMode = enum {
    per_tenant,

    pub const json_field_names = .{
        .per_tenant = "PER_TENANT",
    };
};
