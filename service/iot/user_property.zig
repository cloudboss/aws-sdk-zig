/// A key-value pair that you define in the header. Both the key and the value
/// are either
/// literal strings or valid [substitution
/// templates](https://docs.aws.amazon.com/iot/latest/developerguide/iot-substitution-templates.html).
pub const UserProperty = struct {
    /// A key to be specified in `UserProperty`.
    key: []const u8,

    /// A value to be specified in `UserProperty`.
    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
