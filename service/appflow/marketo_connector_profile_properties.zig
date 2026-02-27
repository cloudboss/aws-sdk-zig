/// The connector-specific profile properties required when using Marketo.
pub const MarketoConnectorProfileProperties = struct {
    /// The location of the Marketo resource.
    instance_url: []const u8,

    pub const json_field_names = .{
        .instance_url = "instanceUrl",
    };
};
