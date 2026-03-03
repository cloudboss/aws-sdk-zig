const StatelessCustomPublishMetricActionDimension = @import("stateless_custom_publish_metric_action_dimension.zig").StatelessCustomPublishMetricActionDimension;

/// Information about metrics to publish to CloudWatch.
pub const StatelessCustomPublishMetricAction = struct {
    /// Defines CloudWatch dimension values to publish.
    dimensions: ?[]const StatelessCustomPublishMetricActionDimension = null,

    pub const json_field_names = .{
        .dimensions = "Dimensions",
    };
};
