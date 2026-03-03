const MemoryStatus = @import("memory_status.zig").MemoryStatus;

/// Contains summary information about a memory resource.
pub const MemorySummary = struct {
    /// The Amazon Resource Name (ARN) of the memory.
    arn: ?[]const u8 = null,

    /// The timestamp when the memory was created.
    created_at: i64,

    /// The unique identifier of the memory.
    id: ?[]const u8 = null,

    /// The current status of the memory.
    status: ?MemoryStatus = null,

    /// The timestamp when the memory was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .id = "id",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
