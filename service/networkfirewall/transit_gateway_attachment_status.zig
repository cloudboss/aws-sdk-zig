pub const TransitGatewayAttachmentStatus = enum {
    creating,
    deleting,
    deleted,
    failed,
    @"error",
    ready,
    pending_acceptance,
    rejecting,
    rejected,

    pub const json_field_names = .{
        .creating = "CREATING",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .failed = "FAILED",
        .@"error" = "ERROR",
        .ready = "READY",
        .pending_acceptance = "PENDING_ACCEPTANCE",
        .rejecting = "REJECTING",
        .rejected = "REJECTED",
    };
};
