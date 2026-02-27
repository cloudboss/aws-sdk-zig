/// A list of key/value pairs that identify a bot, bot alias, or bot
/// channel. Tag keys and values can consist of Unicode letters, digits, white
/// space, and any of the following symbols: _ . : / = + - @.
pub const Tag = struct {
    /// The key for the tag. Keys are not case-sensitive and must be
    /// unique.
    key: []const u8,

    /// The value associated with a key. The value may be an empty string but
    /// it can't be null.
    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
