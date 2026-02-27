/// Additional query string parameter for the connection. You can include up to
/// 100 additional
/// query string parameters per request. Each additional parameter counts
/// towards the event
/// payload size, which cannot exceed 64 KB.
pub const ConnectionQueryStringParameter = struct {
    /// Specifies whether the value is secret.
    is_value_secret: bool = false,

    /// The key for a query string parameter.
    key: ?[]const u8,

    /// The value associated with the key for the query string parameter.
    value: ?[]const u8,

    pub const json_field_names = .{
        .is_value_secret = "IsValueSecret",
        .key = "Key",
        .value = "Value",
    };
};
