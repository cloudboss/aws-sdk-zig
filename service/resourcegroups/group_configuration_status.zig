pub const GroupConfigurationStatus = enum {
    updating,
    update_complete,
    update_failed,

    pub const json_field_names = .{
        .updating = "UPDATING",
        .update_complete = "UPDATE_COMPLETE",
        .update_failed = "UPDATE_FAILED",
    };
};
