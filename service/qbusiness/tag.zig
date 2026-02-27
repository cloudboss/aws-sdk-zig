/// A list of key/value pairs that identify an index, FAQ, or data source. Tag
/// keys and values can consist of Unicode letters, digits, white space, and any
/// of the following symbols: _ . : / = + - @.
pub const Tag = struct {
    /// The key for the tag. Keys are not case sensitive and must be unique for the
    /// Amazon Q Business application or data source.
    key: []const u8,

    /// The value associated with the tag. The value may be an empty string but it
    /// can't be null.
    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
