/// List Connectors Request Filters.
pub const ListConnectorsRequestFilters = struct {
    /// List Connectors Request Filters connector IDs.
    connector_i_ds: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .connector_i_ds = "connectorIDs",
    };
};
