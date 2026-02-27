pub const AccountRoleStatus = enum {
    ready,
    creating,
    pending_deletion,
    deleting,
    deleted,

    pub const json_field_names = .{
        .ready = "Ready",
        .creating = "Creating",
        .pending_deletion = "PendingDeletion",
        .deleting = "Deleting",
        .deleted = "Deleted",
    };
};
