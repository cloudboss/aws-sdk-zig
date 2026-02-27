const MofNApprovalStrategy = @import("mof_n_approval_strategy.zig").MofNApprovalStrategy;

/// Contains details for how an approval team grants approval.
pub const ApprovalStrategyResponse = union(enum) {
    /// Minimum number of approvals (M) required for a total number of approvers
    /// (N).
    mof_n: ?MofNApprovalStrategy,

    pub const json_field_names = .{
        .mof_n = "MofN",
    };
};
