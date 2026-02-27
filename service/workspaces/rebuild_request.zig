/// Describes the information used to rebuild a WorkSpace.
pub const RebuildRequest = struct {
    /// The identifier of the WorkSpace.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .workspace_id = "WorkspaceId",
    };
};
