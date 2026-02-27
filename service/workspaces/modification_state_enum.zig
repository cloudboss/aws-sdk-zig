pub const ModificationStateEnum = enum {
    update_initiated,
    update_in_progress,

    pub const json_field_names = .{
        .update_initiated = "UPDATE_INITIATED",
        .update_in_progress = "UPDATE_IN_PROGRESS",
    };
};
