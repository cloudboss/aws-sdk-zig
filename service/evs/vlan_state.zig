pub const VlanState = enum {
    creating,
    created,
    deleting,
    deleted,
    create_failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .created = "CREATED",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .create_failed = "CREATE_FAILED",
    };
};
