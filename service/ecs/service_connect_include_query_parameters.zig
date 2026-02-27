/// Controls whether query parameters are included in Service Connect access
/// logs.
/// Consider security and privacy implications when enabling this feature. By
/// default, this
/// parameter is `DISABLED`.
pub const ServiceConnectIncludeQueryParameters = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
