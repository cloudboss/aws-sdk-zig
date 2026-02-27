pub const OptInType = enum {
    immediate,
    next_maintenance,
    apply_on,
    undo_opt_in,

    pub const json_field_names = .{
        .immediate = "IMMEDIATE",
        .next_maintenance = "NEXT_MAINTENANCE",
        .apply_on = "APPLY_ON",
        .undo_opt_in = "UNDO_OPT_IN",
    };
};
