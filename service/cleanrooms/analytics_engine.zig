pub const AnalyticsEngine = enum {
    spark,
    clean_rooms_sql,

    pub const json_field_names = .{
        .spark = "SPARK",
        .clean_rooms_sql = "CLEAN_ROOMS_SQL",
    };
};
