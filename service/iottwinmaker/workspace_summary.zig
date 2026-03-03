/// An object that contains information about a workspace.
pub const WorkspaceSummary = struct {
    /// The ARN of the workspace.
    arn: []const u8,

    /// The date and time when the workspace was created.
    creation_date_time: i64,

    /// The description of the workspace.
    description: ?[]const u8 = null,

    /// A list of services that are linked to the workspace.
    linked_services: ?[]const []const u8 = null,

    /// The date and time when the workspace was last updated.
    update_date_time: i64,

    /// The ID of the workspace.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_date_time = "creationDateTime",
        .description = "description",
        .linked_services = "linkedServices",
        .update_date_time = "updateDateTime",
        .workspace_id = "workspaceId",
    };
};
