const OperationStatus = @import("operation_status.zig").OperationStatus;
const OperationType = @import("operation_type.zig").OperationType;

/// Provides summary information for an operation that occurred on an App Runner
/// service.
pub const OperationSummary = struct {
    /// The time when the operation ended. It's in the Unix time stamp format.
    ended_at: ?i64 = null,

    /// A unique ID of this operation. It's unique in the scope of the App Runner
    /// service.
    id: ?[]const u8 = null,

    /// The time when the operation started. It's in the Unix time stamp format.
    started_at: ?i64 = null,

    /// The current state of the operation.
    status: ?OperationStatus = null,

    /// The Amazon Resource Name (ARN) of the resource that the operation acted on
    /// (for example, an App Runner service).
    target_arn: ?[]const u8 = null,

    /// The type of operation. It indicates a specific action that occured.
    @"type": ?OperationType = null,

    /// The time when the operation was last updated. It's in the Unix time stamp
    /// format.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .ended_at = "EndedAt",
        .id = "Id",
        .started_at = "StartedAt",
        .status = "Status",
        .target_arn = "TargetArn",
        .@"type" = "Type",
        .updated_at = "UpdatedAt",
    };
};
