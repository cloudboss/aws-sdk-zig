/// Defines the state of a key
pub const KeyState = enum {
    create_in_progress,
    create_complete,
    delete_pending,
    delete_complete,

    pub const json_field_names = .{
        .create_in_progress = "CREATE_IN_PROGRESS",
        .create_complete = "CREATE_COMPLETE",
        .delete_pending = "DELETE_PENDING",
        .delete_complete = "DELETE_COMPLETE",
    };
};
