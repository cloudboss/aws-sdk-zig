const Status = @import("status.zig").Status;

/// An object that contains information about a component type.
pub const ComponentTypeSummary = struct {
    /// The ARN of the component type.
    arn: []const u8,

    /// The ID of the component type.
    component_type_id: []const u8,

    /// The component type name.
    component_type_name: ?[]const u8 = null,

    /// The date and time when the component type was created.
    creation_date_time: i64,

    /// The description of the component type.
    description: ?[]const u8 = null,

    /// The current status of the component type.
    status: ?Status = null,

    /// The date and time when the component type was last updated.
    update_date_time: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .component_type_id = "componentTypeId",
        .component_type_name = "componentTypeName",
        .creation_date_time = "creationDateTime",
        .description = "description",
        .status = "status",
        .update_date_time = "updateDateTime",
    };
};
