const ErrorDetails = @import("error_details.zig").ErrorDetails;
const Index = @import("index.zig").Index;
const OperationStatus = @import("operation_status.zig").OperationStatus;

/// Contains information about the status of a Resource Explorer index operation
/// in a specific Region.
pub const IndexStatus = struct {
    /// Details about any error that occurred during the index operation.
    error_details: ?ErrorDetails,

    index: ?Index,

    /// The current status of the index operation. Valid values are `SUCCEEDED`,
    /// `FAILED`, `IN_PROGRESS`, or `SKIPPED`.
    status: ?OperationStatus,

    pub const json_field_names = .{
        .error_details = "ErrorDetails",
        .index = "Index",
        .status = "Status",
    };
};
