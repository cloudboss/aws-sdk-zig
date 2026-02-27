pub const ViewDialect = enum {
    redshift,
    athena,
    spark,

    pub const json_field_names = .{
        .redshift = "REDSHIFT",
        .athena = "ATHENA",
        .spark = "SPARK",
    };
};
