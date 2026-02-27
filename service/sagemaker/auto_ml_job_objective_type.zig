pub const AutoMLJobObjectiveType = enum {
    maximize,
    minimize,

    pub const json_field_names = .{
        .maximize = "MAXIMIZE",
        .minimize = "MINIMIZE",
    };
};
