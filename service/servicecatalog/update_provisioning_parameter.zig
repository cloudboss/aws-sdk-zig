/// The parameter key-value pair used to update a provisioned product.
pub const UpdateProvisioningParameter = struct {
    /// The parameter key.
    key: ?[]const u8,

    /// If set to true, `Value` is ignored and the previous parameter value is kept.
    use_previous_value: bool = false,

    /// The parameter value.
    value: ?[]const u8,

    pub const json_field_names = .{
        .key = "Key",
        .use_previous_value = "UsePreviousValue",
        .value = "Value",
    };
};
