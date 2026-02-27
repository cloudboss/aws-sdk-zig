const ExecutionRecordStatus = @import("execution_record_status.zig").ExecutionRecordStatus;

/// Contains information about a test case execution record.
pub const ExecutionRecord = struct {
    /// The identifier of the execution record.
    observation_id: ?[]const u8,

    /// The details of the executed record.
    record: ?[]const u8,

    /// The status of the action execution.
    status: ?ExecutionRecordStatus,

    /// The timestamp when the action was executed.
    timestamp: ?i64,

    pub const json_field_names = .{
        .observation_id = "ObservationId",
        .record = "Record",
        .status = "Status",
        .timestamp = "Timestamp",
    };
};
