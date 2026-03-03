/// Describes the information used to stop a WorkSpace.
pub const StopRequest = struct {
    /// The identifier of the WorkSpace.
    workspace_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .workspace_id = "WorkspaceId",
    };
};
