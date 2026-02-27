/// Parameters for Amazon Aurora PostgreSQL-Compatible Edition.
pub const AuroraPostgreSqlParameters = struct {
    /// The Amazon Aurora PostgreSQL database to connect to.
    database: []const u8,

    /// The Amazon Aurora PostgreSQL-Compatible host to connect to.
    host: []const u8,

    /// The port that Amazon Aurora PostgreSQL is listening on.
    port: i32,

    pub const json_field_names = .{
        .database = "Database",
        .host = "Host",
        .port = "Port",
    };
};
