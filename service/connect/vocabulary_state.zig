pub const VocabularyState = enum {
    creation_in_progress,
    active,
    creation_failed,
    delete_in_progress,

    pub const json_field_names = .{
        .creation_in_progress = "CREATION_IN_PROGRESS",
        .active = "ACTIVE",
        .creation_failed = "CREATION_FAILED",
        .delete_in_progress = "DELETE_IN_PROGRESS",
    };
};
