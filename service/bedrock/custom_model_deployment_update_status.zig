pub const CustomModelDeploymentUpdateStatus = enum {
    updating,
    update_completed,
    update_failed,

    pub const json_field_names = .{
        .updating = "UPDATING",
        .update_completed = "UPDATE_COMPLETED",
        .update_failed = "UPDATE_FAILED",
    };
};
