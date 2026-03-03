const OperationStatus = @import("operation_status.zig").OperationStatus;

/// A description of the aplication operation that provides information about
/// the updates that were made to the application.
pub const ApplicationOperationInfo = struct {
    /// The timestamp that indicates when the operation finished.
    end_time: ?i64 = null,

    operation: ?[]const u8 = null,

    operation_id: ?[]const u8 = null,

    operation_status: ?OperationStatus = null,

    /// The timestamp that indicates when the operation was created.
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .operation = "Operation",
        .operation_id = "OperationId",
        .operation_status = "OperationStatus",
        .start_time = "StartTime",
    };
};
