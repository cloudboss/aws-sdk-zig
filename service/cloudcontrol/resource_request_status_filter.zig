const Operation = @import("operation.zig").Operation;
const OperationStatus = @import("operation_status.zig").OperationStatus;

/// The filter criteria to use in determining the requests returned.
pub const ResourceRequestStatusFilter = struct {
    /// The operation types to include in the filter.
    operations: ?[]const Operation,

    /// The operation statuses to include in the filter.
    ///
    /// * `PENDING`: The operation has been requested, but not yet initiated.
    ///
    /// * `IN_PROGRESS`: The operation is in progress.
    ///
    /// * `SUCCESS`: The operation completed.
    ///
    /// * `FAILED`: The operation failed.
    ///
    /// * `CANCEL_IN_PROGRESS`: The operation is in the process of being
    /// canceled.
    ///
    /// * `CANCEL_COMPLETE`: The operation has been canceled.
    operation_statuses: ?[]const OperationStatus,

    pub const json_field_names = .{
        .operations = "Operations",
        .operation_statuses = "OperationStatuses",
    };
};
