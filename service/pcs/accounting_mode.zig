pub const AccountingMode = enum {
    standard,
    none,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .none = "NONE",
    };
};
