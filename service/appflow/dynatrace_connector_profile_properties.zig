/// The connector-specific profile properties required by Dynatrace.
pub const DynatraceConnectorProfileProperties = struct {
    /// The location of the Dynatrace resource.
    instance_url: []const u8,

    pub const json_field_names = .{
        .instance_url = "instanceUrl",
    };
};
