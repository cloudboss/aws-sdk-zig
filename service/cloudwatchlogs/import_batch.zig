const ImportStatus = @import("import_status.zig").ImportStatus;

/// A collection of events being imported to CloudWatch
pub const ImportBatch = struct {
    /// The unique identifier of the import batch.
    batch_id: []const u8,

    /// The error message if the batch failed to import. Only present when status is
    /// FAILED.
    error_message: ?[]const u8,

    /// The current status of the import batch. Valid values are IN_PROGRESS,
    /// CANCELLED, COMPLETED and FAILED.
    status: ImportStatus,

    pub const json_field_names = .{
        .batch_id = "batchId",
        .error_message = "errorMessage",
        .status = "status",
    };
};
