/// Provides summary information about an App Runner observability configuration
/// resource.
///
/// This type contains limited information about an observability configuration.
/// It includes only identification information, without configuration
/// details. It's returned by the ListObservabilityConfigurations action.
/// Complete configuration information is returned by the
/// CreateObservabilityConfiguration, DescribeObservabilityConfiguration, and
/// DeleteObservabilityConfiguration
/// actions using the ObservabilityConfiguration type.
pub const ObservabilityConfigurationSummary = struct {
    /// The Amazon Resource Name (ARN) of this observability configuration.
    observability_configuration_arn: ?[]const u8,

    /// The customer-provided observability configuration name. It can be used in
    /// multiple revisions of a configuration.
    observability_configuration_name: ?[]const u8,

    /// The revision of this observability configuration. It's unique among all the
    /// active configurations (`"Status": "ACTIVE"`) that share the
    /// same `ObservabilityConfigurationName`.
    observability_configuration_revision: i32 = 0,

    pub const json_field_names = .{
        .observability_configuration_arn = "ObservabilityConfigurationArn",
        .observability_configuration_name = "ObservabilityConfigurationName",
        .observability_configuration_revision = "ObservabilityConfigurationRevision",
    };
};
