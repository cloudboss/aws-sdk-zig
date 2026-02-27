/// Metadata assigned to a directory consisting of a key-value pair.
pub const Tag = struct {
    /// Required name of the tag. The string value can be Unicode characters and
    /// cannot be
    /// prefixed with "aws:". The string can contain only the set of Unicode
    /// letters, digits,
    /// white-space, '_', '.', '/', '=', '+', '-', ':', '@'(Java regex:
    /// "^([\\p{L}\\p{Z}\\p{N}_.:/=+\\-]*)$").
    key: []const u8,

    /// The optional value of the tag. The string value can be Unicode characters.
    /// The string
    /// can contain only the set of Unicode letters, digits, white-space, '_', '.',
    /// '/', '=', '+', '-', ':', '@'
    /// (Java regex: "^([\\p{L}\\p{Z}\\p{N}_.:/=+\\-]*)$").
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
