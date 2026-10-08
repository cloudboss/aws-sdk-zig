/// Describes a single configuration value that does not match the intended
/// configuration.
pub const ConfigurationIssue = struct {
    /// The configuration value that was found on the resource.
    actual_value: ?[]const u8 = null,

    /// The name of the configuration setting that is in conflict.
    configuration_name: ?[]const u8 = null,

    /// The configuration value that AWS Network Security Manager expected.
    expected_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .actual_value = "actualValue",
        .configuration_name = "configurationName",
        .expected_value = "expectedValue",
    };
};
