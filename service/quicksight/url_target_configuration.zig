pub const URLTargetConfiguration = enum {
    new_tab,
    new_window,
    same_tab,

    pub const json_field_names = .{
        .new_tab = "NEW_TAB",
        .new_window = "NEW_WINDOW",
        .same_tab = "SAME_TAB",
    };
};
