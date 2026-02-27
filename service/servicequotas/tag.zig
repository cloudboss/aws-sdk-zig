/// A complex data type that contains a tag key and tag value.
pub const Tag = struct {
    /// A string that contains a tag key. The string length should be between 1 and
    /// 128
    /// characters. Valid characters include a-z, A-Z, 0-9, space, and the special
    /// characters _
    /// - . : / = + @.
    key: []const u8,

    /// A string that contains an optional tag value. The string length should be
    /// between 0
    /// and 256 characters. Valid characters include a-z, A-Z, 0-9, space, and the
    /// special
    /// characters _ - . : / = + @.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
