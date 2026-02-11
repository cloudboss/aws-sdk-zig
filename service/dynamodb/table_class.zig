pub const TableClass = enum {
    standard,
    standard_infrequent_access,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .standard_infrequent_access = "STANDARD_INFREQUENT_ACCESS",
    };
};
