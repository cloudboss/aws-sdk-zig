pub const UpdateStatus = enum {
    updated,
    updating,
    update_failed,

    pub const json_field_names = .{
        .updated = "UPDATED",
        .updating = "UPDATING",
        .update_failed = "UPDATE_FAILED",
    };
};
