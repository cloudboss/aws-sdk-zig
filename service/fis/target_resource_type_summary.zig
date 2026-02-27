/// Describes a resource type.
pub const TargetResourceTypeSummary = struct {
    /// A description of the resource type.
    description: ?[]const u8,

    /// The resource type.
    resource_type: ?[]const u8,

    pub const json_field_names = .{
        .description = "description",
        .resource_type = "resourceType",
    };
};
