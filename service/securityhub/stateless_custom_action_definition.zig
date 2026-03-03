const StatelessCustomPublishMetricAction = @import("stateless_custom_publish_metric_action.zig").StatelessCustomPublishMetricAction;

/// The definition of a custom action that can be used for stateless packet
/// handling.
pub const StatelessCustomActionDefinition = struct {
    /// Information about metrics to publish to CloudWatch.
    publish_metric_action: ?StatelessCustomPublishMetricAction = null,

    pub const json_field_names = .{
        .publish_metric_action = "PublishMetricAction",
    };
};
