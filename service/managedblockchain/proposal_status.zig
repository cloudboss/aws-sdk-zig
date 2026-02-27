pub const ProposalStatus = enum {
    in_progress,
    approved,
    rejected,
    expired,
    action_failed,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .approved = "APPROVED",
        .rejected = "REJECTED",
        .expired = "EXPIRED",
        .action_failed = "ACTION_FAILED",
    };
};
