const JiraCloudDetail = @import("jira_cloud_detail.zig").JiraCloudDetail;
const ServiceNowDetail = @import("service_now_detail.zig").ServiceNowDetail;

/// The third-party provider detail for a service configuration.
pub const ProviderDetail = union(enum) {
    /// Details about a Jira Cloud integration.
    jira_cloud: ?JiraCloudDetail,
    /// Details about a ServiceNow ITSM integration.
    service_now: ?ServiceNowDetail,

    pub const json_field_names = .{
        .jira_cloud = "JiraCloud",
        .service_now = "ServiceNow",
    };
};
