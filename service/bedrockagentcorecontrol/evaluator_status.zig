pub const EvaluatorStatus = enum {
    active,
    creating,
    create_failed,
    updating,
    update_failed,
    deleting,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .creating = "CREATING",
        .create_failed = "CREATE_FAILED",
        .updating = "UPDATING",
        .update_failed = "UPDATE_FAILED",
        .deleting = "DELETING",
    };
};
