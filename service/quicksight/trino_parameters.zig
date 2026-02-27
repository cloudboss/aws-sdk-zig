/// The parameters that are required to connect to a Trino data source.
pub const TrinoParameters = struct {
    /// The catalog name for the Trino data source.
    catalog: []const u8,

    /// The host name of the Trino data source.
    host: []const u8,

    /// The port for the Trino data source.
    port: i32,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .host = "Host",
        .port = "Port",
    };
};
