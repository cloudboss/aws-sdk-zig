const QuotaShareInSharePreemptionState = @import("quota_share_in_share_preemption_state.zig").QuotaShareInSharePreemptionState;

/// Specifies the preemption behavior for jobs in a quota share.
pub const QuotaSharePreemptionConfiguration = struct {
    /// Specifies whether jobs within a quota share can be preempted by another,
    /// higher priority job in the same quota share.
    in_share_preemption: QuotaShareInSharePreemptionState,

    pub const json_field_names = .{
        .in_share_preemption = "inSharePreemption",
    };
};
