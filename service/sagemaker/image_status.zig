pub const ImageStatus = enum {
    creating,
    created,
    create_failed,
    updating,
    update_failed,
    deleting,
    delete_failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .created = "CREATED",
        .create_failed = "CREATE_FAILED",
        .updating = "UPDATING",
        .update_failed = "UPDATE_FAILED",
        .deleting = "DELETING",
        .delete_failed = "DELETE_FAILED",
    };
};
