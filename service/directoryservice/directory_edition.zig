pub const DirectoryEdition = enum {
    enterprise,
    standard,
    hybrid,

    pub const json_field_names = .{
        .enterprise = "ENTERPRISE",
        .standard = "STANDARD",
        .hybrid = "HYBRID",
    };
};
