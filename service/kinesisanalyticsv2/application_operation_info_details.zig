const ApplicationVersionChangeDetails = @import("application_version_change_details.zig").ApplicationVersionChangeDetails;
const OperationFailureDetails = @import("operation_failure_details.zig").OperationFailureDetails;
const OperationStatus = @import("operation_status.zig").OperationStatus;

/// A description of the application operation that provides information about
/// the updates that were made to the application.
pub const ApplicationOperationInfoDetails = struct {
    application_version_change_details: ?ApplicationVersionChangeDetails,

    /// The timestamp that indicates when the operation finished.
    end_time: i64,

    operation: []const u8,

    operation_failure_details: ?OperationFailureDetails,

    operation_status: OperationStatus,

    /// The timestamp that indicates when the operation was created.
    start_time: i64,

    pub const json_field_names = .{
        .application_version_change_details = "ApplicationVersionChangeDetails",
        .end_time = "EndTime",
        .operation = "Operation",
        .operation_failure_details = "OperationFailureDetails",
        .operation_status = "OperationStatus",
        .start_time = "StartTime",
    };
};
