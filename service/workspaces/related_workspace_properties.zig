const WorkspaceState = @import("workspace_state.zig").WorkspaceState;
const StandbyWorkspaceRelationshipType = @import("standby_workspace_relationship_type.zig").StandbyWorkspaceRelationshipType;

/// Describes the related WorkSpace. The related WorkSpace could be a standby
/// WorkSpace or
/// primary WorkSpace related to the specified WorkSpace.
pub const RelatedWorkspaceProperties = struct {
    /// The Region of the related WorkSpace.
    region: ?[]const u8 = null,

    /// Indicates the state of the WorkSpace.
    state: ?WorkspaceState = null,

    /// Indicates the type of WorkSpace.
    @"type": ?StandbyWorkspaceRelationshipType = null,

    /// The identifier of the related WorkSpace.
    workspace_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .region = "Region",
        .state = "State",
        .@"type" = "Type",
        .workspace_id = "WorkspaceId",
    };
};
