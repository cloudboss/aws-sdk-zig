/// A key-value pair that identifies or categorizes an index, FAQ,
/// data source, or other resource. TA tag key and value can consist of Unicode
/// letters,
/// digits, white space, and any of the following symbols: _ . : / = + - @.
pub const Tag = struct {
    /// The key for the tag. Keys are not case sensitive and must be unique for the
    /// index, FAQ,
    /// data source, or other resource.
    key: []const u8,

    /// The value associated with the tag. The value may be an empty string but it
    /// can't be
    /// null.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
