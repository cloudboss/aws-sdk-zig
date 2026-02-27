pub const Action = enum {
    initialize_reset,
    perform_reset,

    pub const json_field_names = .{
        .initialize_reset = "INITIALIZE_RESET",
        .perform_reset = "PERFORM_RESET",
    };
};
