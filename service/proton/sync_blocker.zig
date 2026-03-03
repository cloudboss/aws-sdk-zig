const SyncBlockerContext = @import("sync_blocker_context.zig").SyncBlockerContext;
const BlockerStatus = @import("blocker_status.zig").BlockerStatus;
const BlockerType = @import("blocker_type.zig").BlockerType;

/// Detailed data of the sync blocker.
pub const SyncBlocker = struct {
    /// The contexts for the sync blocker.
    contexts: ?[]const SyncBlockerContext = null,

    /// The time when the sync blocker was created.
    created_at: i64,

    /// The reason why the sync blocker was created.
    created_reason: []const u8,

    /// The ID of the sync blocker.
    id: []const u8,

    /// The time the sync blocker was resolved.
    resolved_at: ?i64 = null,

    /// The reason the sync blocker was resolved.
    resolved_reason: ?[]const u8 = null,

    /// The status of the sync blocker.
    status: BlockerStatus,

    /// The type of the sync blocker.
    @"type": BlockerType,

    pub const json_field_names = .{
        .contexts = "contexts",
        .created_at = "createdAt",
        .created_reason = "createdReason",
        .id = "id",
        .resolved_at = "resolvedAt",
        .resolved_reason = "resolvedReason",
        .status = "status",
        .@"type" = "type",
    };
};
