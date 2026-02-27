/// The unique key-value pair
/// for a tag
/// that identifies provisioned product resources.
pub const UniqueTagResourceIdentifier = struct {
    /// A unique key
    /// that's attached
    /// to a resource.
    key: ?[]const u8,

    /// A unique value
    /// that's attached
    /// to a resource.
    value: ?[]const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
