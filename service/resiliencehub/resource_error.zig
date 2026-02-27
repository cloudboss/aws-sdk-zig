/// Defines application resource errors.
pub const ResourceError = struct {
    /// Identifier of the logical resource.
    logical_resource_id: ?[]const u8,

    /// Identifier of the physical resource.
    physical_resource_id: ?[]const u8,

    /// This is the error message.
    reason: ?[]const u8,

    pub const json_field_names = .{
        .logical_resource_id = "logicalResourceId",
        .physical_resource_id = "physicalResourceId",
        .reason = "reason",
    };
};
