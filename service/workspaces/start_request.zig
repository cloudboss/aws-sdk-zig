/// Information used to start a WorkSpace.
pub const StartRequest = struct {
    /// The identifier of the WorkSpace.
    workspace_id: ?[]const u8,

    pub const json_field_names = .{
        .workspace_id = "WorkspaceId",
    };
};
