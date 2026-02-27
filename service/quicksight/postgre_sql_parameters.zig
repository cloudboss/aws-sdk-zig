/// The parameters for PostgreSQL.
pub const PostgreSqlParameters = struct {
    /// Database.
    database: []const u8,

    /// Host.
    host: []const u8,

    /// Port.
    port: i32,

    pub const json_field_names = .{
        .database = "Database",
        .host = "Host",
        .port = "Port",
    };
};
