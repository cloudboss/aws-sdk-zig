/// Information about an application revision.
pub const GenericRevisionInfo = struct {
    /// The deployment groups for which this is the current target revision.
    deployment_groups: ?[]const []const u8,

    /// A comment about the revision.
    description: ?[]const u8,

    /// When the revision was first used by CodeDeploy.
    first_used_time: ?i64,

    /// When the revision was last used by CodeDeploy.
    last_used_time: ?i64,

    /// When the revision was registered with CodeDeploy.
    register_time: ?i64,

    pub const json_field_names = .{
        .deployment_groups = "deploymentGroups",
        .description = "description",
        .first_used_time = "firstUsedTime",
        .last_used_time = "lastUsedTime",
        .register_time = "registerTime",
    };
};
