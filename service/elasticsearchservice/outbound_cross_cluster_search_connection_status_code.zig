pub const OutboundCrossClusterSearchConnectionStatusCode = enum {
    pending_acceptance,
    validating,
    validation_failed,
    provisioning,
    active,
    rejected,
    deleting,
    deleted,

    pub const json_field_names = .{
        .pending_acceptance = "PENDING_ACCEPTANCE",
        .validating = "VALIDATING",
        .validation_failed = "VALIDATION_FAILED",
        .provisioning = "PROVISIONING",
        .active = "ACTIVE",
        .rejected = "REJECTED",
        .deleting = "DELETING",
        .deleted = "DELETED",
    };
};
