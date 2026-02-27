pub const Sector = enum {
    commercial,
    government,
    government_exception,

    pub const json_field_names = .{
        .commercial = "COMMERCIAL",
        .government = "GOVERNMENT",
        .government_exception = "GOVERNMENT_EXCEPTION",
    };
};
