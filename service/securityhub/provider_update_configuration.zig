const AzureUpdateConfiguration = @import("azure_update_configuration.zig").AzureUpdateConfiguration;
const JiraCloudUpdateConfiguration = @import("jira_cloud_update_configuration.zig").JiraCloudUpdateConfiguration;
const ServiceNowUpdateConfiguration = @import("service_now_update_configuration.zig").ServiceNowUpdateConfiguration;

/// The parameters required to update the configuration of an integration
/// provider.
pub const ProviderUpdateConfiguration = union(enum) {
    /// The parameters required to update the configuration for a Microsoft Azure
    /// CSPM integration.
    azure: ?AzureUpdateConfiguration,
    /// The parameters required to update the configuration for a Jira Cloud
    /// integration.
    jira_cloud: ?JiraCloudUpdateConfiguration,
    /// The parameters required to update the configuration for a ServiceNow
    /// integration.
    service_now: ?ServiceNowUpdateConfiguration,

    pub const json_field_names = .{
        .azure = "Azure",
        .jira_cloud = "JiraCloud",
        .service_now = "ServiceNow",
    };
};
