pub const QuerySuggestionsBlockListStatus = enum {
    active,
    creating,
    deleting,
    updating,
    active_but_update_failed,
    failed,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .creating = "CREATING",
        .deleting = "DELETING",
        .updating = "UPDATING",
        .active_but_update_failed = "ACTIVE_BUT_UPDATE_FAILED",
        .failed = "FAILED",
    };
};
