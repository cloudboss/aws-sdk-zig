/// Details about a connection missing required configuration.
pub const MissingConnectionConfigurationFlowValidationDetails = struct {
    /// The name of the connection missing configuration.
    connection: []const u8,

    pub const json_field_names = .{
        .connection = "connection",
    };
};
