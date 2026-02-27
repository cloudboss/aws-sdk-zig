pub const MigrationSortAttribute = enum {
    v1_bot_name,
    migration_date_time,

    pub const json_field_names = .{
        .v1_bot_name = "V1_BOT_NAME",
        .migration_date_time = "MIGRATION_DATE_TIME",
    };
};
