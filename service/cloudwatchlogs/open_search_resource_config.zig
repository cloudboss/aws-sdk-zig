/// This structure contains configuration details about an integration between
/// CloudWatch Logs and OpenSearch Service.
pub const OpenSearchResourceConfig = struct {
    /// If you want to use an existing OpenSearch Service application for your
    /// integration with
    /// OpenSearch Service, specify it here. If you omit this, a new application
    /// will be
    /// created.
    application_arn: ?[]const u8 = null,

    /// Specify the ARNs of IAM roles and IAM users who you want to
    /// grant permission to for viewing the dashboards.
    ///
    /// In addition to specifying these users here, you must also grant them the
    /// **CloudWatchOpenSearchDashboardAccess**
    /// IAM policy. For more information, see [IAM policies for
    /// users](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/OpenSearch-Dashboards-UserRoles.html).
    dashboard_viewer_principals: []const []const u8,

    /// Specify the ARN of an IAM role that CloudWatch Logs will use to create
    /// the integration. This role must have the permissions necessary to access the
    /// OpenSearch Service collection to be able to create the dashboards. For more
    /// information about the permissions
    /// needed, see [Permissions that
    /// the integration
    /// needs](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/OpenSearch-Dashboards-CreateRole.html) in the CloudWatch Logs User Guide.
    data_source_role_arn: []const u8,

    /// To have the vended dashboard data encrypted with KMS instead of the
    /// CloudWatch Logs default encryption method, specify the ARN of the KMS key
    /// that you
    /// want to use.
    kms_key_arn: ?[]const u8 = null,

    /// Specify how many days that you want the data derived by OpenSearch Service
    /// to be retained
    /// in the index that the dashboard refers to. This also sets the maximum time
    /// period that you can
    /// choose when viewing data in the dashboard. Choosing a longer time frame will
    /// incur additional
    /// costs.
    retention_days: i32,

    pub const json_field_names = .{
        .application_arn = "applicationArn",
        .dashboard_viewer_principals = "dashboardViewerPrincipals",
        .data_source_role_arn = "dataSourceRoleArn",
        .kms_key_arn = "kmsKeyArn",
        .retention_days = "retentionDays",
    };
};
