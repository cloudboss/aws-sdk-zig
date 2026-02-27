/// The HTTP action header.
pub const HttpActionHeader = struct {
    /// The HTTP header key.
    key: []const u8,

    /// The HTTP header value. Substitution templates are supported.
    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
