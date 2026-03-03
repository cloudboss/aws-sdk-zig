const ServiceType = @import("service_type.zig").ServiceType;

/// The summary of a domain configuration. A domain configuration specifies
/// custom IoT-specific information about a domain.
/// A domain configuration can be associated with an Amazon Web Services-managed
/// domain
/// (for example, dbc123defghijk.iot.us-west-2.amazonaws.com), a customer
/// managed domain, or a default endpoint.
///
/// * Data
///
/// * Jobs
///
/// * CredentialProvider
pub const DomainConfigurationSummary = struct {
    /// The ARN of the domain configuration.
    domain_configuration_arn: ?[]const u8 = null,

    /// The name of the domain configuration. This value must be unique to a region.
    domain_configuration_name: ?[]const u8 = null,

    /// The type of service delivered by the endpoint.
    service_type: ?ServiceType = null,

    pub const json_field_names = .{
        .domain_configuration_arn = "domainConfigurationArn",
        .domain_configuration_name = "domainConfigurationName",
        .service_type = "serviceType",
    };
};
