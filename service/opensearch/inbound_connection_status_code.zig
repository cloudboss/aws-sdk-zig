pub const InboundConnectionStatusCode = enum {
    pending_acceptance,
    approved,
    provisioning,
    active,
    rejecting,
    rejected,
    deleting,
    deleted,

    pub const json_field_names = .{
        .pending_acceptance = "PENDING_ACCEPTANCE",
        .approved = "APPROVED",
        .provisioning = "PROVISIONING",
        .active = "ACTIVE",
        .rejecting = "REJECTING",
        .rejected = "REJECTED",
        .deleting = "DELETING",
        .deleted = "DELETED",
    };
};
