/// Describes a target for an action.
pub const ActionTarget = struct {
    /// The resource type of the target.
    resource_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .resource_type = "resourceType",
    };
};
