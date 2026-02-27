pub const ControlResponse = enum {
    manual,
    automate,
    @"defer",
    ignore,

    pub const json_field_names = .{
        .manual = "MANUAL",
        .automate = "AUTOMATE",
        .@"defer" = "DEFER",
        .ignore = "IGNORE",
    };
};
