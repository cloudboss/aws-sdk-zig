const ResourceMetricSelection = @import("resource_metric_selection.zig").ResourceMetricSelection;

/// Represents a resource metrics configuration for an Amazon Web Services
/// resource. A
/// resource metrics configuration enables detailed metric collection for the
/// resource that
/// is identified by its Amazon Resource Name (ARN). Each Amazon Web Services
/// resource can
/// have only one resource metrics configuration.
///
/// This structure is returned by the
/// [CreateResourceMetricsConfiguration](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_CreateResourceMetricsConfiguration.html), [UpdateResourceMetricsConfiguration](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_UpdateResourceMetricsConfiguration.html), and [GetResourceMetricsConfiguration](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_GetResourceMetricsConfiguration.html) operations.
pub const ResourceMetricsConfiguration = struct {
    /// The date and time that the resource metrics configuration was created.
    created_at: i64,

    /// The metrics that Amazon CloudWatch collects for the resource. If this field
    /// is not
    /// present, Amazon CloudWatch collects all available detailed metrics for the
    /// resource.
    metric_selections: ?[]const ResourceMetricSelection = null,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services resource that this
    /// configuration applies to.
    resource_arn: []const u8,

    /// The date and time that the resource metrics configuration was last updated.
    /// When the
    /// configuration is first created, this value is the same as
    /// `CreatedAt`.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .metric_selections = "MetricSelections",
        .resource_arn = "ResourceArn",
        .updated_at = "UpdatedAt",
    };
};
