/// The source identifying the HTTP connector integration.
pub const HttpConnectorSource = struct {
    /// The identifier for the HTTP connector integration.
    connector_id: []const u8,

    pub const json_field_names = .{
        .connector_id = "connectorId",
    };
};
