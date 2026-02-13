pub const PatchDeploymentStatus = enum {
    approved,
    pending_approval,
    explicit_approved,
    explicit_rejected,

    pub const json_field_names = .{
        .approved = "Approved",
        .pending_approval = "PendingApproval",
        .explicit_approved = "ExplicitApproved",
        .explicit_rejected = "ExplicitRejected",
    };
};
