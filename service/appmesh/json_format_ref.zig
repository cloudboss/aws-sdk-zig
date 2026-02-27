/// An object that represents the key value pairs for the JSON.
pub const JsonFormatRef = struct {
    /// The specified key for the JSON.
    key: []const u8,

    /// The specified value for the JSON.
    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
