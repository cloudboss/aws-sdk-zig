pub const StandardsControlsUpdatable = enum {
    ready_for_updates,
    not_ready_for_updates,

    pub const json_field_names = .{
        .ready_for_updates = "READY_FOR_UPDATES",
        .not_ready_for_updates = "NOT_READY_FOR_UPDATES",
    };
};
