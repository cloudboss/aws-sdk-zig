const ErrorDetails = @import("error_details.zig").ErrorDetails;
const OperationStatus = @import("operation_status.zig").OperationStatus;
const View = @import("view.zig").View;

/// Contains information about the status of a Resource Explorer view operation
/// in a specific Region.
pub const ViewStatus = struct {
    /// Details about any error that occurred during the view operation.
    error_details: ?ErrorDetails,

    /// The current status of the view operation. Valid values are `SUCCEEDED`,
    /// `FAILED`, `IN_PROGRESS`, or `SKIPPED`.
    status: ?OperationStatus,

    view: ?View,

    pub const json_field_names = .{
        .error_details = "ErrorDetails",
        .status = "Status",
        .view = "View",
    };
};
