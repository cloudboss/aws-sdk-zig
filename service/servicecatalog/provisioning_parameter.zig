/// Information about a parameter used to provision a product.
pub const ProvisioningParameter = struct {
    /// The parameter key.
    key: ?[]const u8,

    /// The parameter value.
    value: ?[]const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
