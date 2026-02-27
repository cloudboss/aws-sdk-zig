const ErrorDetails = @import("error_details.zig").ErrorDetails;
const SyncResourceState = @import("sync_resource_state.zig").SyncResourceState;

/// The sync resource status.
pub const SyncResourceStatus = struct {
    /// The status error.
    @"error": ?ErrorDetails,

    /// The sync resource status state.
    state: ?SyncResourceState,

    pub const json_field_names = .{
        .@"error" = "error",
        .state = "state",
    };
};
