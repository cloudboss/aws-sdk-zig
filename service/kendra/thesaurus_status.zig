pub const ThesaurusStatus = enum {
    creating,
    active,
    deleting,
    updating,
    active_but_update_failed,
    failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .deleting = "DELETING",
        .updating = "UPDATING",
        .active_but_update_failed = "ACTIVE_BUT_UPDATE_FAILED",
        .failed = "FAILED",
    };
};
