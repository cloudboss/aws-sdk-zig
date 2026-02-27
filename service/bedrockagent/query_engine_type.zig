pub const QueryEngineType = enum {
    redshift,

    pub const json_field_names = .{
        .redshift = "REDSHIFT",
    };
};
