/// Defines application resource errors.
pub const ResourceError = struct {
    /// Identifier of the logical resource.
    logical_resource_id: ?[]const u8 = null,

    /// Identifier of the physical resource.
    physical_resource_id: ?[]const u8 = null,

    /// This is the error message.
    reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .logical_resource_id = "logicalResourceId",
        .physical_resource_id = "physicalResourceId",
        .reason = "reason",
    };
};
