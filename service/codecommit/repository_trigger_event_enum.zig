pub const RepositoryTriggerEventEnum = enum {
    all,
    update_reference,
    create_reference,
    delete_reference,

    pub const json_field_names = .{
        .all = "ALL",
        .update_reference = "UPDATE_REFERENCE",
        .create_reference = "CREATE_REFERENCE",
        .delete_reference = "DELETE_REFERENCE",
    };
};
