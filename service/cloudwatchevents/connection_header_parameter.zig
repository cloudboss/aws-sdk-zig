/// Additional parameter included in the header. You can include up to 100
/// additional header
/// parameters per request. An event payload cannot exceed 64 KB.
pub const ConnectionHeaderParameter = struct {
    /// Specified whether the value is a secret.
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
