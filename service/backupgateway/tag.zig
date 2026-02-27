/// A key-value pair you can use to manage, filter, and search for your
/// resources. Allowed
/// characters include UTF-8 letters, numbers, spaces, and the following
/// characters: + - = . _ :
/// /.
pub const Tag = struct {
    /// The key part of a tag's key-value pair. The key can't start with `aws:`.
    key: []const u8,

    /// The value part of a tag's key-value pair.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
