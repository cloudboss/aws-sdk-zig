/// The parameters for Oracle.
pub const OracleParameters = struct {
    /// The database.
    database: []const u8,

    /// An Oracle host.
    host: []const u8,

    /// The port.
    port: i32,

    /// A Boolean value that indicates whether the `Database` uses a service name or
    /// an SID. If this value is left blank, the default value is `SID`. If this
    /// value is set to `false`, the value is `SID`.
    use_service_name: bool = false,

    pub const json_field_names = .{
        .database = "Database",
        .host = "Host",
        .port = "Port",
        .use_service_name = "UseServiceName",
    };
};
