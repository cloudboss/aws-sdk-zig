/// A key and value pair that is associated with the specified signaling
/// channel.
pub const Tag = struct {
    /// The key of the tag that is associated with the specified signaling channel.
    key: []const u8,

    /// The value of the tag that is associated with the specified signaling
    /// channel.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
