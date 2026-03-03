const ControlOperationType = @import("control_operation_type.zig").ControlOperationType;
const ControlOperationStatus = @import("control_operation_status.zig").ControlOperationStatus;

/// An operation performed by the control.
pub const ControlOperation = struct {
    /// The `controlIdentifier` of the control for the operation.
    control_identifier: ?[]const u8 = null,

    /// The `controlIdentifier` of the enabled control.
    enabled_control_identifier: ?[]const u8 = null,

    /// The time that the operation finished.
    end_time: ?i64 = null,

    /// The identifier of the specified operation.
    operation_identifier: ?[]const u8 = null,

    /// One of `ENABLE_CONTROL` or `DISABLE_CONTROL`.
    operation_type: ?ControlOperationType = null,

    /// The time that the operation began.
    start_time: ?i64 = null,

    /// One of `IN_PROGRESS`, `SUCEEDED`, or `FAILED`.
    status: ?ControlOperationStatus = null,

    /// If the operation result is `FAILED`, this string contains a message
    /// explaining why the operation failed.
    status_message: ?[]const u8 = null,

    /// The target upon which the control operation is working.
    target_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .control_identifier = "controlIdentifier",
        .enabled_control_identifier = "enabledControlIdentifier",
        .end_time = "endTime",
        .operation_identifier = "operationIdentifier",
        .operation_type = "operationType",
        .start_time = "startTime",
        .status = "status",
        .status_message = "statusMessage",
        .target_identifier = "targetIdentifier",
    };
};
