pub const ModelApprovalStatus = enum {
    approved,
    rejected,
    pending_manual_approval,

    pub const json_field_names = .{
        .approved = "APPROVED",
        .rejected = "REJECTED",
        .pending_manual_approval = "PENDING_MANUAL_APPROVAL",
    };
};
