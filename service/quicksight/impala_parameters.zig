/// The parameters that are required to connect to a Impala data source.
pub const ImpalaParameters = struct {
    /// The database of the Impala data source.
    database: ?[]const u8,

    /// The host name of the Impala data source.
    host: []const u8,

    /// The port of the Impala data source.
    port: i32,

    /// The HTTP path of the Impala data source.
    sql_endpoint_path: []const u8,

    pub const json_field_names = .{
        .database = "Database",
        .host = "Host",
        .port = "Port",
        .sql_endpoint_path = "SqlEndpointPath",
    };
};
