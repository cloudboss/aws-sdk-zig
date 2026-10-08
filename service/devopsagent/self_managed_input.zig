/// Configuration for a self-managed Private Connection.
pub const SelfManagedInput = struct {
    /// Certificate for the Private Connection.
    certificate: ?[]const u8 = null,

    /// The ID or ARN of the resource configuration.
    resource_configuration_id: []const u8,

    pub const json_field_names = .{
        .certificate = "certificate",
        .resource_configuration_id = "resourceConfigurationId",
    };
};
