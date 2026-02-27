const JiraCloudUpdateConfiguration = @import("jira_cloud_update_configuration.zig").JiraCloudUpdateConfiguration;
const ServiceNowUpdateConfiguration = @import("service_now_update_configuration.zig").ServiceNowUpdateConfiguration;

/// The parameters required to update the configuration of an integration
/// provider.
pub const ProviderUpdateConfiguration = union(enum) {
    /// The parameters required to update the configuration for a Jira Cloud
    /// integration.
    jira_cloud: ?JiraCloudUpdateConfiguration,
    /// The parameters required to update the configuration for a ServiceNow
    /// integration.
    service_now: ?ServiceNowUpdateConfiguration,

    pub const json_field_names = .{
        .jira_cloud = "JiraCloud",
        .service_now = "ServiceNow",
    };
};
