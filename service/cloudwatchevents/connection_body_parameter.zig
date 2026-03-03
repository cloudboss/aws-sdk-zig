/// Additional parameter included in the body. You can include up to 100
/// additional body
/// parameters per request. An event payload cannot exceed 64 KB.
pub const ConnectionBodyParameter = struct {
    /// Specified whether the value is secret.
    is_value_secret: bool = false,

    /// The key for the parameter.
    key: ?[]const u8 = null,

    /// The value associated with the key.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .is_value_secret = "IsValueSecret",
        .key = "Key",
        .value = "Value",
    };
};
