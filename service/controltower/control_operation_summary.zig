const ControlOperationType = @import("control_operation_type.zig").ControlOperationType;
const ControlOperationStatus = @import("control_operation_status.zig").ControlOperationStatus;

/// A summary of information about the specified control operation.
pub const ControlOperationSummary = struct {
    /// The `controlIdentifier` of a control.
    control_identifier: ?[]const u8 = null,

    /// The `controlIdentifier` of an enabled control.
    enabled_control_identifier: ?[]const u8 = null,

    /// The time at which the control operation was completed.
    end_time: ?i64 = null,

    /// The unique identifier of a control operation.
    operation_identifier: ?[]const u8 = null,

    /// The type of operation.
    operation_type: ?ControlOperationType = null,

    /// The time at which a control operation began.
    start_time: ?i64 = null,

    /// The status of the specified control operation.
    status: ?ControlOperationStatus = null,

    /// A speficic message displayed as part of the control status.
    status_message: ?[]const u8 = null,

    /// The unique identifier of the target of a control operation.
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
