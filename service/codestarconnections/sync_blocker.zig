const SyncBlockerContext = @import("sync_blocker_context.zig").SyncBlockerContext;
const BlockerStatus = @import("blocker_status.zig").BlockerStatus;
const BlockerType = @import("blocker_type.zig").BlockerType;

/// Information about a blocker for a sync event.
pub const SyncBlocker = struct {
    /// The contexts for a specific sync blocker.
    contexts: ?[]const SyncBlockerContext,

    /// The creation time for a specific sync blocker.
    created_at: i64,

    /// The provided reason for a specific sync blocker.
    created_reason: []const u8,

    /// The ID for a specific sync blocker.
    id: []const u8,

    /// The time that a specific sync blocker was resolved.
    resolved_at: ?i64,

    /// The resolved reason for a specific sync blocker.
    resolved_reason: ?[]const u8,

    /// The status for a specific sync blocker.
    status: BlockerStatus,

    /// The sync blocker type.
    type: BlockerType,

    pub const json_field_names = .{
        .contexts = "Contexts",
        .created_at = "CreatedAt",
        .created_reason = "CreatedReason",
        .id = "Id",
        .resolved_at = "ResolvedAt",
        .resolved_reason = "ResolvedReason",
        .status = "Status",
        .type = "Type",
    };
};
