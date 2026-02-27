pub const KxScalingGroupStatus = enum {
    creating,
    create_failed,
    active,
    deleting,
    deleted,
    delete_failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .create_failed = "CREATE_FAILED",
        .active = "ACTIVE",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .delete_failed = "DELETE_FAILED",
    };
};
