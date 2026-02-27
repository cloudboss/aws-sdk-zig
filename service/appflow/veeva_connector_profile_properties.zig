/// The connector-specific profile properties required when using Veeva.
pub const VeevaConnectorProfileProperties = struct {
    /// The location of the Veeva resource.
    instance_url: []const u8,

    pub const json_field_names = .{
        .instance_url = "instanceUrl",
    };
};
