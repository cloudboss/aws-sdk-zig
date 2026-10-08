/// The configuration for a self-managed private connection.
pub const SelfManagedInput = struct {
    /// The certificate for the private connection.
    certificate: ?[]const u8 = null,

    /// The identifier or ARN of the resource configuration.
    resource_configuration_id: []const u8,

    pub const json_field_names = .{
        .certificate = "certificate",
        .resource_configuration_id = "resourceConfigurationId",
    };
};
