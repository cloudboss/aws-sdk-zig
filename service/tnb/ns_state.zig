pub const NsState = enum {
    instantiated,
    not_instantiated,
    updated,
    impaired,
    update_failed,
    stopped,
    deleted,
    instantiate_in_progress,
    intent_to_update_in_progress,
    update_in_progress,
    terminate_in_progress,

    pub const json_field_names = .{
        .instantiated = "INSTANTIATED",
        .not_instantiated = "NOT_INSTANTIATED",
        .updated = "UPDATED",
        .impaired = "IMPAIRED",
        .update_failed = "UPDATE_FAILED",
        .stopped = "STOPPED",
        .deleted = "DELETED",
        .instantiate_in_progress = "INSTANTIATE_IN_PROGRESS",
        .intent_to_update_in_progress = "INTENT_TO_UPDATE_IN_PROGRESS",
        .update_in_progress = "UPDATE_IN_PROGRESS",
        .terminate_in_progress = "TERMINATE_IN_PROGRESS",
    };
};
