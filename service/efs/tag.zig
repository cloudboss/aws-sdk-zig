/// A tag is a key-value pair. Allowed characters are letters, white space, and
/// numbers that
/// can be represented in UTF-8, and the following characters:` + - = . _ : /`.
pub const Tag = struct {
    /// The tag key (String). The key can't start with `aws:`.
    key: []const u8,

    /// The value of the tag key.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
