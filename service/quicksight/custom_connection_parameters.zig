/// The parameters that are required to connect to a custom connection data
/// source.
pub const CustomConnectionParameters = struct {
    /// The type of custom connector.
    connection_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .connection_type = "ConnectionType",
    };
};
