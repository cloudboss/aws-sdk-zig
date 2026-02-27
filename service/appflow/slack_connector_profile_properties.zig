/// The connector-specific profile properties required when using Slack.
pub const SlackConnectorProfileProperties = struct {
    /// The location of the Slack resource.
    instance_url: []const u8,

    pub const json_field_names = .{
        .instance_url = "instanceUrl",
    };
};
