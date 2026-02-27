/// The connector-specific profile properties required when using Zendesk.
pub const ZendeskConnectorProfileProperties = struct {
    /// The location of the Zendesk resource.
    instance_url: []const u8,

    pub const json_field_names = .{
        .instance_url = "instanceUrl",
    };
};
