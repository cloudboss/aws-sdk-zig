/// Represents a custom HTTP header that can be included in AS2 messages. Each
/// header consists of a key-value pair.
pub const CustomHttpHeader = struct {
    /// The name of the custom HTTP header.
    key: ?[]const u8,

    /// The value of the custom HTTP header.
    value: ?[]const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
