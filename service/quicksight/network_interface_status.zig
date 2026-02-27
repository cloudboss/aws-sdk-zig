pub const NetworkInterfaceStatus = enum {
    creating,
    available,
    creation_failed,
    updating,
    update_failed,
    deleting,
    deleted,
    deletion_failed,
    deletion_scheduled,
    attachment_failed_rollback_failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .available = "AVAILABLE",
        .creation_failed = "CREATION_FAILED",
        .updating = "UPDATING",
        .update_failed = "UPDATE_FAILED",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .deletion_failed = "DELETION_FAILED",
        .deletion_scheduled = "DELETION_SCHEDULED",
        .attachment_failed_rollback_failed = "ATTACHMENT_FAILED_ROLLBACK_FAILED",
    };
};
