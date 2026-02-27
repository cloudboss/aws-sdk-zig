/// Describes the information used to reboot a WorkSpace.
pub const RebootRequest = struct {
    /// The identifier of the WorkSpace.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .workspace_id = "WorkspaceId",
    };
};
