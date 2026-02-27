/// A key-value pair that can be attached to a dashboard for organization and
/// management purposes.
pub const ResourceTag = struct {
    /// The key of the tag to be attached to the dashboard resource.
    key: []const u8,

    /// The value of the tag to be attached to the dashboard resource.
    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
