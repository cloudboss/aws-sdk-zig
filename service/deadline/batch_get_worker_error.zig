const BatchGetWorkerErrorCode = @import("batch_get_worker_error_code.zig").BatchGetWorkerErrorCode;

/// The error details for a worker that could not be retrieved in a batch get
/// operation.
pub const BatchGetWorkerError = struct {
    /// The error code.
    code: BatchGetWorkerErrorCode,

    /// The farm ID of the worker that could not be retrieved.
    farm_id: []const u8,

    /// The fleet ID of the worker that could not be retrieved.
    fleet_id: []const u8,

    /// The error message.
    message: []const u8,

    /// The worker ID of the worker that could not be retrieved.
    worker_id: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .farm_id = "farmId",
        .fleet_id = "fleetId",
        .message = "message",
        .worker_id = "workerId",
    };
};
