const QuotaShareIdleResourceAssignmentStrategy = @import("quota_share_idle_resource_assignment_strategy.zig").QuotaShareIdleResourceAssignmentStrategy;

/// The quota share scheduling policy details for a job queue.
pub const QuotaSharePolicy = struct {
    /// The strategy that determines how idle resources are assigned to quota shares
    /// that are borrowing capacity. Currently, only `FIFO` is supported.
    idle_resource_assignment_strategy: QuotaShareIdleResourceAssignmentStrategy,

    pub const json_field_names = .{
        .idle_resource_assignment_strategy = "idleResourceAssignmentStrategy",
    };
};
