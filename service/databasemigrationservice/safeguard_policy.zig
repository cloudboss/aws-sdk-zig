pub const SafeguardPolicy = enum {
    rely_on_sql_server_replication_agent,
    exclusive_automatic_truncation,
    shared_automatic_truncation,

    pub const json_field_names = .{
        .rely_on_sql_server_replication_agent = "RELY_ON_SQL_SERVER_REPLICATION_AGENT",
        .exclusive_automatic_truncation = "EXCLUSIVE_AUTOMATIC_TRUNCATION",
        .shared_automatic_truncation = "SHARED_AUTOMATIC_TRUNCATION",
    };
};
