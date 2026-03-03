/// Describes a remediation action target.
pub const ActionTarget = struct {
    /// A description of the remediation action target.
    description: ?[]const u8 = null,

    /// The ID of the remediation target.
    resource_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .resource_id = "ResourceId",
    };
};
