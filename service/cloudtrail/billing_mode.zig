pub const BillingMode = enum {
    extendable_retention_pricing,
    fixed_retention_pricing,

    pub const json_field_names = .{
        .extendable_retention_pricing = "EXTENDABLE_RETENTION_PRICING",
        .fixed_retention_pricing = "FIXED_RETENTION_PRICING",
    };
};
