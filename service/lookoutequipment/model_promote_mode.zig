pub const ModelPromoteMode = enum {
    managed,
    manual,

    pub const json_field_names = .{
        .managed = "MANAGED",
        .manual = "MANUAL",
    };
};
