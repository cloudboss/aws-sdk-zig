/// Strategy for how an approval team grants approval.
pub const MofNApprovalStrategy = struct {
    /// Minimum number of approvals (M) required for a total number of approvers
    /// (N).
    min_approvals_required: i32,

    pub const json_field_names = .{
        .min_approvals_required = "MinApprovalsRequired",
    };
};
