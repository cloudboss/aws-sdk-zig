const OperationStatus = @import("operation_status.zig").OperationStatus;

/// A complex type that contains information about an operation that matches the
/// criteria that
/// you specified in a
/// [ListOperations](https://docs.aws.amazon.com/cloud-map/latest/api/API_ListOperations.html) request.
pub const OperationSummary = struct {
    /// The ID for an operation.
    id: ?[]const u8,

    /// The status of the operation. Values include the following:
    ///
    /// * **SUBMITTED**: This is the initial state immediately after
    /// you submit a request.
    ///
    /// * **PENDING**: Cloud Map is performing the operation.
    ///
    /// * **SUCCESS**: The operation succeeded.
    ///
    /// * **FAIL**: The operation failed. For the failure reason, see
    /// `ErrorMessage`.
    status: ?OperationStatus,

    pub const json_field_names = .{
        .id = "Id",
        .status = "Status",
    };
};
