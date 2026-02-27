pub const SupportType = enum {
    standard,
    extended,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .extended = "EXTENDED",
    };
};
