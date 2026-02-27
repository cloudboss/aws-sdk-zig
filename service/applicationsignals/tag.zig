/// A key-value pair associated with a resource. Tags can help you organize and
/// categorize your resources.
pub const Tag = struct {
    /// A string that you can use to assign a value. The combination of tag keys and
    /// values can help you organize and categorize your resources.
    key: []const u8,

    /// The value for the specified tag key.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
