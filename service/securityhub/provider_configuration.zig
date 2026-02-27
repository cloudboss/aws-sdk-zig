const JiraCloudProviderConfiguration = @import("jira_cloud_provider_configuration.zig").JiraCloudProviderConfiguration;
const ServiceNowProviderConfiguration = @import("service_now_provider_configuration.zig").ServiceNowProviderConfiguration;

/// The initial configuration settings required to establish an integration
/// between Security Hub and third-party provider.
pub const ProviderConfiguration = union(enum) {
    /// The configuration settings required to establish an integration with Jira
    /// Cloud.
    jira_cloud: ?JiraCloudProviderConfiguration,
    /// The configuration settings required to establish an integration with
    /// ServiceNow ITSM.
    service_now: ?ServiceNowProviderConfiguration,

    pub const json_field_names = .{
        .jira_cloud = "JiraCloud",
        .service_now = "ServiceNow",
    };
};
