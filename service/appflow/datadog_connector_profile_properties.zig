/// The connector-specific profile properties required by Datadog.
pub const DatadogConnectorProfileProperties = struct {
    /// The location of the Datadog resource.
    instance_url: []const u8,

    pub const json_field_names = .{
        .instance_url = "instanceUrl",
    };
};
