/// Describes the observability configuration of an App Runner service. These
/// are additional observability features, like tracing, that you choose to
/// enable. They're configured in a separate resource that you associate with
/// your service.
pub const ServiceObservabilityConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the observability configuration that is
    /// associated with the service. Specified only when
    /// `ObservabilityEnabled` is `true`.
    ///
    /// Specify an ARN with a name and a revision number to associate that revision.
    /// For example:
    /// `arn:aws:apprunner:us-east-1:123456789012:observabilityconfiguration/xray-tracing/3`
    ///
    /// Specify just the name to associate the latest revision. For example:
    /// `arn:aws:apprunner:us-east-1:123456789012:observabilityconfiguration/xray-tracing`
    observability_configuration_arn: ?[]const u8 = null,

    /// When `true`, an observability configuration resource is associated with the
    /// service, and an `ObservabilityConfigurationArn` is
    /// specified.
    observability_enabled: bool = false,

    pub const json_field_names = .{
        .observability_configuration_arn = "ObservabilityConfigurationArn",
        .observability_enabled = "ObservabilityEnabled",
    };
};
