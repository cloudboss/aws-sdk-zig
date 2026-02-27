const DiscoveryType = @import("discovery_type.zig").DiscoveryType;

/// Describes the status of the application.
pub const ApplicationInfo = struct {
    /// The Amazon Web Services account ID for the owner of the application.
    account_id: ?[]const u8,

    /// If set to true, the managed policies for SSM and CW will be attached to the
    /// instance roles if they are missing.
    attach_missing_permission: ?bool,

    /// Indicates whether auto-configuration is turned on for this application.
    auto_config_enabled: ?bool,

    /// Indicates whether Application Insights can listen to CloudWatch events for
    /// the
    /// application resources, such as `instance terminated`, `failed
    /// deployment`, and others.
    cwe_monitor_enabled: ?bool,

    /// The method used by Application Insights to onboard your resources.
    discovery_type: ?DiscoveryType,

    /// The lifecycle of the application.
    life_cycle: ?[]const u8,

    /// Indicates whether Application Insights will create opsItems for any problem
    /// detected by
    /// Application Insights for an application.
    ops_center_enabled: ?bool,

    /// The SNS topic provided to Application Insights that is associated to the
    /// created
    /// opsItems to receive SNS notifications for opsItem updates.
    ops_item_sns_topic_arn: ?[]const u8,

    /// The issues on the user side that block Application Insights from
    /// successfully monitoring
    /// an application. Example remarks include:
    ///
    /// * “Configuring application, detected 1 Errors, 3 Warnings”
    ///
    /// * “Configuring application, detected 1 Unconfigured Components”
    remarks: ?[]const u8,

    /// The name of the resource group used for the application.
    resource_group_name: ?[]const u8,

    /// The SNS topic ARN that is associated with SNS notifications for updates or
    /// issues.
    sns_notification_arn: ?[]const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .attach_missing_permission = "AttachMissingPermission",
        .auto_config_enabled = "AutoConfigEnabled",
        .cwe_monitor_enabled = "CWEMonitorEnabled",
        .discovery_type = "DiscoveryType",
        .life_cycle = "LifeCycle",
        .ops_center_enabled = "OpsCenterEnabled",
        .ops_item_sns_topic_arn = "OpsItemSNSTopicArn",
        .remarks = "Remarks",
        .resource_group_name = "ResourceGroupName",
        .sns_notification_arn = "SNSNotificationArn",
    };
};
