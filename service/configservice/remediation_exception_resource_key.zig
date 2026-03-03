/// The details that identify a resource within Config, including the resource
/// type and resource ID.
pub const RemediationExceptionResourceKey = struct {
    /// The ID of the resource (for example., sg-xxxxxx).
    resource_id: ?[]const u8 = null,

    /// The type of a resource.
    resource_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
    };
};
