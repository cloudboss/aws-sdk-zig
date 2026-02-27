pub const InboundCrossClusterSearchConnectionStatusCode = enum {
    pending_acceptance,
    approved,
    rejecting,
    rejected,
    deleting,
    deleted,

    pub const json_field_names = .{
        .pending_acceptance = "PENDING_ACCEPTANCE",
        .approved = "APPROVED",
        .rejecting = "REJECTING",
        .rejected = "REJECTED",
        .deleting = "DELETING",
        .deleted = "DELETED",
    };
};
