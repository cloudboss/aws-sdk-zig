/// The connector-specific profile properties required when using ServiceNow.
pub const ServiceNowConnectorProfileProperties = struct {
    /// The location of the ServiceNow resource.
    instance_url: []const u8,

    pub const json_field_names = .{
        .instance_url = "instanceUrl",
    };
};
