const MemoryRecordStatus = @import("memory_record_status.zig").MemoryRecordStatus;

/// Output information returned after processing a memory record operation.
pub const MemoryRecordOutput = struct {
    /// The error code returned when the memory record operation fails.
    error_code: ?i32,

    /// A human-readable error message describing why the memory record operation
    /// failed.
    error_message: ?[]const u8,

    /// The unique ID associated to the memory record.
    memory_record_id: []const u8,

    /// The client-provided identifier that was used to track this record operation.
    request_identifier: ?[]const u8,

    /// The status of the memory record operation (e.g., SUCCEEDED, FAILED).
    status: MemoryRecordStatus,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .memory_record_id = "memoryRecordId",
        .request_identifier = "requestIdentifier",
        .status = "status",
    };
};
