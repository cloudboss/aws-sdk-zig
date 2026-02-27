pub const ShareStatus = enum {
    shared,
    pending_acceptance,
    rejected,
    rejecting,
    reject_failed,
    sharing,
    share_failed,
    deleted,
    deleting,

    pub const json_field_names = .{
        .shared = "SHARED",
        .pending_acceptance = "PENDING_ACCEPTANCE",
        .rejected = "REJECTED",
        .rejecting = "REJECTING",
        .reject_failed = "REJECT_FAILED",
        .sharing = "SHARING",
        .share_failed = "SHARE_FAILED",
        .deleted = "DELETED",
        .deleting = "DELETING",
    };
};
