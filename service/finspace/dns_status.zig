pub const dnsStatus = enum {
    none,
    update_requested,
    updating,
    failed_update,
    successfully_updated,

    pub const json_field_names = .{
        .none = "NONE",
        .update_requested = "UPDATE_REQUESTED",
        .updating = "UPDATING",
        .failed_update = "FAILED_UPDATE",
        .successfully_updated = "SUCCESSFULLY_UPDATED",
    };
};
