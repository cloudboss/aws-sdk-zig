/// The target workspace configuration for a migration. You can specify an
/// existing workspace by ID or request creation of a new workspace.
pub const MigrationWorkspace = struct {
    /// Specifies whether to create a new workspace as the migration target. If
    /// `true`, you must also specify `name`.
    create_workspace: ?bool = null,

    /// The name of the new workspace to create. Required when `createWorkspace` is
    /// `true`.
    name: ?[]const u8 = null,

    /// The type of the new workspace to create.
    type: ?[]const u8 = null,

    /// The unique identifier of an existing workspace to use as the migration
    /// target. Specify either this parameter or `createWorkspace`.
    workspace_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .create_workspace = "createWorkspace",
        .name = "name",
        .type = "type",
        .workspace_id = "workspaceId",
    };
};
