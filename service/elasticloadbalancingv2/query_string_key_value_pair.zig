/// Information about a key/value pair.
pub const QueryStringKeyValuePair = struct {
    /// The key. You can omit the key.
    key: ?[]const u8 = null,

    /// The value.
    value: ?[]const u8 = null,
};
