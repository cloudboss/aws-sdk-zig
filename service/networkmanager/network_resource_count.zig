/// Describes a resource count.
pub const NetworkResourceCount = struct {
    /// The resource count.
    count: ?i32 = null,

    /// The resource type.
    resource_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .count = "Count",
        .resource_type = "ResourceType",
    };
};
