pub const PartnerAppStatus = enum {
    creating,
    updating,
    deleting,
    available,
    failed,
    update_failed,
    deleted,

    pub const json_field_names = .{
        .creating = "CREATING",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .available = "AVAILABLE",
        .failed = "FAILED",
        .update_failed = "UPDATE_FAILED",
        .deleted = "DELETED",
    };
};
