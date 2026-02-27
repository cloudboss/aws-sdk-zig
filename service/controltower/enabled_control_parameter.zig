/// A key/value pair, where `Key` is of type `String` and `Value` is of type
/// `Document`.
pub const EnabledControlParameter = struct {
    /// The key of a key/value pair.
    key: []const u8,

    /// The value of a key/value pair.
    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
