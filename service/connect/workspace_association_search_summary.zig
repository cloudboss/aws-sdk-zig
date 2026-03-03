/// Contains summary information about a workspace association with a user or
/// routing profile.
pub const WorkspaceAssociationSearchSummary = struct {
    /// The Amazon Resource Name (ARN) of the associated resource.
    resource_arn: ?[]const u8 = null,

    /// The identifier of the associated resource (user or routing profile).
    resource_id: ?[]const u8 = null,

    /// The name of the associated resource.
    resource_name: ?[]const u8 = null,

    /// The type of resource associated with the workspace. Valid values are: `USER`
    /// and
    /// `ROUTING_PROFILE`.
    resource_type: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the workspace.
    workspace_arn: ?[]const u8 = null,

    /// The identifier of the workspace.
    workspace_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .resource_id = "ResourceId",
        .resource_name = "ResourceName",
        .resource_type = "ResourceType",
        .workspace_arn = "WorkspaceArn",
        .workspace_id = "WorkspaceId",
    };
};
