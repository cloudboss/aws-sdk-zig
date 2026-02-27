pub const ChannelStatus = enum {
    created,
    creating,
    create_failed,
    deleted,
    deleting,
    delete_failed,

    pub const json_field_names = .{
        .created = "CREATED",
        .creating = "CREATING",
        .create_failed = "CREATE_FAILED",
        .deleted = "DELETED",
        .deleting = "DELETING",
        .delete_failed = "DELETE_FAILED",
    };
};
