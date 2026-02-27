pub const FargateProfileStatus = enum {
    creating,
    active,
    deleting,
    create_failed,
    delete_failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .deleting = "DELETING",
        .create_failed = "CREATE_FAILED",
        .delete_failed = "DELETE_FAILED",
    };
};
