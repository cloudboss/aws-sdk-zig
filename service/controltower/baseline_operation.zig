const BaselineOperationType = @import("baseline_operation_type.zig").BaselineOperationType;
const BaselineOperationStatus = @import("baseline_operation_status.zig").BaselineOperationStatus;

/// An object of shape `BaselineOperation`, returning details about the
/// specified `Baseline` operation ID.
pub const BaselineOperation = struct {
    /// The end time of the operation (if applicable), in ISO 8601 format.
    end_time: ?i64 = null,

    /// The identifier of the specified operation.
    operation_identifier: ?[]const u8 = null,

    /// An enumerated type (`enum`) with possible values of `ENABLE_BASELINE`,
    /// `DISABLE_BASELINE`, `UPDATE_ENABLED_BASELINE`, or `RESET_ENABLED_BASELINE`.
    operation_type: ?BaselineOperationType = null,

    /// The start time of the operation, in ISO 8601 format.
    start_time: ?i64 = null,

    /// An enumerated type (`enum`) with possible values of `SUCCEEDED`, `FAILED`,
    /// or `IN_PROGRESS`.
    status: ?BaselineOperationStatus = null,

    /// A status message that gives more information about the operation's status,
    /// if applicable.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .end_time = "endTime",
        .operation_identifier = "operationIdentifier",
        .operation_type = "operationType",
        .start_time = "startTime",
        .status = "status",
        .status_message = "statusMessage",
    };
};
