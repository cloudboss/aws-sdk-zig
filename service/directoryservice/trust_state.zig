pub const TrustState = enum {
    creating,
    created,
    verifying,
    verify_failed,
    verified,
    updating,
    update_failed,
    updated,
    deleting,
    deleted,
    failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .created = "CREATED",
        .verifying = "VERIFYING",
        .verify_failed = "VERIFY_FAILED",
        .verified = "VERIFIED",
        .updating = "UPDATING",
        .update_failed = "UPDATE_FAILED",
        .updated = "UPDATED",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .failed = "FAILED",
    };
};
