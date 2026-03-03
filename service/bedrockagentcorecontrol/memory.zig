const MemoryStatus = @import("memory_status.zig").MemoryStatus;
const MemoryStrategy = @import("memory_strategy.zig").MemoryStrategy;

/// Contains information about a memory resource.
pub const Memory = struct {
    /// The Amazon Resource Name (ARN) of the memory.
    arn: []const u8,

    /// The timestamp when the memory was created.
    created_at: i64,

    /// The description of the memory.
    description: ?[]const u8 = null,

    /// The ARN of the KMS key used to encrypt the memory.
    encryption_key_arn: ?[]const u8 = null,

    /// The number of days after which memory events will expire.
    event_expiry_duration: i32,

    /// The reason for failure if the memory is in a failed state.
    failure_reason: ?[]const u8 = null,

    /// The unique identifier of the memory.
    id: []const u8,

    /// The ARN of the IAM role that provides permissions for the memory.
    memory_execution_role_arn: ?[]const u8 = null,

    /// The name of the memory.
    name: []const u8,

    /// The current status of the memory.
    status: MemoryStatus,

    /// The list of memory strategies associated with this memory.
    strategies: ?[]const MemoryStrategy = null,

    /// The timestamp when the memory was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .description = "description",
        .encryption_key_arn = "encryptionKeyArn",
        .event_expiry_duration = "eventExpiryDuration",
        .failure_reason = "failureReason",
        .id = "id",
        .memory_execution_role_arn = "memoryExecutionRoleArn",
        .name = "name",
        .status = "status",
        .strategies = "strategies",
        .updated_at = "updatedAt",
    };
};
