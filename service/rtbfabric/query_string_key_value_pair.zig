/// A key-value pair for query string matching in a routing rule condition.
pub const QueryStringKeyValuePair = struct {
    /// The key of the query string parameter to match. Must contain only RFC 3986
    /// unreserved characters.
    key: []const u8,

    /// The value of the query string parameter to match. Must contain only RFC 3986
    /// unreserved characters.
    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
