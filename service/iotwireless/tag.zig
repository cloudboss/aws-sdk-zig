/// A simple label consisting of a customer-defined key-value pair
pub const Tag = struct {
    /// The tag's key value.
    key: []const u8,

    /// The tag's value.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
