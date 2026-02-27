/// The parameters that are required to connect to a Databricks data source.
pub const DatabricksParameters = struct {
    /// The host name of the Databricks data source.
    host: []const u8,

    /// The port for the Databricks data source.
    port: i32,

    /// The HTTP path of the Databricks data source.
    sql_endpoint_path: []const u8,

    pub const json_field_names = .{
        .host = "Host",
        .port = "Port",
        .sql_endpoint_path = "SqlEndpointPath",
    };
};
