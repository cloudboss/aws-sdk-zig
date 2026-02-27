/// The required parameters for connecting to an Exasol data source.
pub const ExasolParameters = struct {
    /// The hostname or IP address of the Exasol data source.
    host: []const u8,

    /// The port for the Exasol data source.
    port: i32,

    pub const json_field_names = .{
        .host = "Host",
        .port = "Port",
    };
};
