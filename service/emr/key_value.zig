/// A key-value pair.
pub const KeyValue = struct {
    /// The unique identifier of a key-value pair.
    key: ?[]const u8 = null,

    /// The value part of the identified key.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
