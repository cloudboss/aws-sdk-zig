const WorkspaceErrorDetails = @import("workspace_error_details.zig").WorkspaceErrorDetails;
const WorkspaceState = @import("workspace_state.zig").WorkspaceState;

/// Contains information about the current status of a workspace.
pub const WorkspaceStatus = struct {
    /// Contains associated error information, if any.
    @"error": ?WorkspaceErrorDetails = null,

    /// The current state of the workspace.
    state: WorkspaceState,

    pub const json_field_names = .{
        .@"error" = "error",
        .state = "state",
    };
};
