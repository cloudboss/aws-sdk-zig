const QueueBlockedReason = @import("queue_blocked_reason.zig").QueueBlockedReason;
const DefaultQueueBudgetAction = @import("default_queue_budget_action.zig").DefaultQueueBudgetAction;
const QueueStatus = @import("queue_status.zig").QueueStatus;

/// The details of a queue summary.
pub const QueueSummary = struct {
    /// The reason the queue is blocked, if applicable.
    blocked_reason: ?QueueBlockedReason = null,

    /// The date and time the resource was created.
    created_at: i64,

    /// The user or system that created this resource.
    created_by: []const u8,

    /// The default action taken on a queue summary if a budget wasn't configured.
    default_budget_action: DefaultQueueBudgetAction,

    /// The display name of the queue summary to update.
    ///
    /// This field can store any content. Escape or encode this content before
    /// displaying it on a webpage or any other system that might interpret the
    /// content of this field.
    display_name: []const u8,

    /// The farm ID.
    farm_id: []const u8,

    /// The queue ID.
    queue_id: []const u8,

    /// That status of the queue.
    status: QueueStatus,

    /// The date and time the resource was updated.
    updated_at: ?i64 = null,

    /// The user or system that updated this resource.
    updated_by: ?[]const u8 = null,

    pub const json_field_names = .{
        .blocked_reason = "blockedReason",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .default_budget_action = "defaultBudgetAction",
        .display_name = "displayName",
        .farm_id = "farmId",
        .queue_id = "queueId",
        .status = "status",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};
