/// A summary of a resource available on the device.
pub const ResourceSummary = struct {
    /// The Amazon Resource Name (ARN) of the resource.
    arn: ?[]const u8 = null,

    /// The ID of the resource.
    id: ?[]const u8 = null,

    /// The resource type.
    resource_type: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .id = "id",
        .resource_type = "resourceType",
    };
};
