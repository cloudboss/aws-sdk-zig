/// A list of information about the configuration.
pub const ConfigurationId = struct {
    /// Required. The unique ID that Amazon MQ generates for the configuration.
    id: []const u8,

    /// The revision number of the configuration.
    revision: ?i32,

    pub const json_field_names = .{
        .id = "Id",
        .revision = "Revision",
    };
};
