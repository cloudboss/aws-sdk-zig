/// A key-value pair that helps you manage, filter, and search for your
/// resource. Allowed
/// characters: letters, white space, and numbers, representable in UTF-8, and
/// the following
/// characters: + - = . _ : /.
pub const Tag = struct {
    /// Tag key. The key can't start with aws:.
    key: []const u8,

    /// Value of the tag key.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
