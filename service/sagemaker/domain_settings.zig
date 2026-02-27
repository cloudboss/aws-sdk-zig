const AmazonQSettings = @import("amazon_q_settings.zig").AmazonQSettings;
const DockerSettings = @import("docker_settings.zig").DockerSettings;
const ExecutionRoleIdentityConfig = @import("execution_role_identity_config.zig").ExecutionRoleIdentityConfig;
const IPAddressType = @import("ip_address_type.zig").IPAddressType;
const RStudioServerProDomainSettings = @import("r_studio_server_pro_domain_settings.zig").RStudioServerProDomainSettings;
const TrustedIdentityPropagationSettings = @import("trusted_identity_propagation_settings.zig").TrustedIdentityPropagationSettings;
const UnifiedStudioSettings = @import("unified_studio_settings.zig").UnifiedStudioSettings;

/// A collection of settings that apply to the `SageMaker Domain`. These
/// settings are specified through the `CreateDomain` API call.
pub const DomainSettings = struct {
    /// A collection of settings that configure the Amazon Q experience within the
    /// domain. The `AuthMode` that you use to create the domain must be `SSO`.
    amazon_q_settings: ?AmazonQSettings,

    /// A collection of settings that configure the domain's Docker interaction.
    docker_settings: ?DockerSettings,

    /// The configuration for attaching a SageMaker AI user profile name to the
    /// execution role as a [sts:SourceIdentity
    /// key](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_control-access_monitor.html).
    execution_role_identity_config: ?ExecutionRoleIdentityConfig,

    /// The IP address type for the domain. Specify `ipv4` for IPv4-only
    /// connectivity or `dualstack` for both IPv4 and IPv6 connectivity. When you
    /// specify `dualstack`, the subnet must support IPv6 CIDR blocks. If not
    /// specified, defaults to `ipv4`.
    ip_address_type: ?IPAddressType,

    /// A collection of settings that configure the `RStudioServerPro` Domain-level
    /// app.
    r_studio_server_pro_domain_settings: ?RStudioServerProDomainSettings,

    /// The security groups for the Amazon Virtual Private Cloud that the `Domain`
    /// uses for communication between Domain-level apps and user apps.
    security_group_ids: ?[]const []const u8,

    /// The Trusted Identity Propagation (TIP) settings for the SageMaker domain.
    /// These settings determine how user identities from IAM Identity Center are
    /// propagated through the domain to TIP enabled Amazon Web Services services.
    trusted_identity_propagation_settings: ?TrustedIdentityPropagationSettings,

    /// The settings that apply to an SageMaker AI domain when you use it in Amazon
    /// SageMaker Unified Studio.
    unified_studio_settings: ?UnifiedStudioSettings,

    pub const json_field_names = .{
        .amazon_q_settings = "AmazonQSettings",
        .docker_settings = "DockerSettings",
        .execution_role_identity_config = "ExecutionRoleIdentityConfig",
        .ip_address_type = "IpAddressType",
        .r_studio_server_pro_domain_settings = "RStudioServerProDomainSettings",
        .security_group_ids = "SecurityGroupIds",
        .trusted_identity_propagation_settings = "TrustedIdentityPropagationSettings",
        .unified_studio_settings = "UnifiedStudioSettings",
    };
};
