const SetupExecutionDetails = @import("setup_execution_details.zig").SetupExecutionDetails;
const SetupRequest = @import("setup_request.zig").SetupRequest;
const SetupHistoryResource = @import("setup_history_resource.zig").SetupHistoryResource;
const SetupStatus = @import("setup_status.zig").SetupStatus;

/// Returns a list of the commands that were ran on the target resource.
///
/// The status of each command is also returned.
pub const SetupHistory = struct {
    /// Describes the full details of the request.
    execution_details: ?[]const SetupExecutionDetails = null,

    /// A GUID that's used to identify the operation.
    operation_id: ?[]const u8 = null,

    /// Information about the specified request.
    request: ?SetupRequest = null,

    /// The target resource name for the request.
    resource: ?SetupHistoryResource = null,

    /// The status of the request.
    status: ?SetupStatus = null,

    pub const json_field_names = .{
        .execution_details = "executionDetails",
        .operation_id = "operationId",
        .request = "request",
        .resource = "resource",
        .status = "status",
    };
};
