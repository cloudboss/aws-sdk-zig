const PublishMetricAction = @import("publish_metric_action.zig").PublishMetricAction;

/// A custom action to use in stateless rule actions settings. This is used in
/// CustomAction.
pub const ActionDefinition = struct {
    /// Stateless inspection criteria that publishes the specified metrics to Amazon
    /// CloudWatch for the
    /// matching packet. This setting defines a CloudWatch dimension value to be
    /// published.
    ///
    /// You can pair this custom action with any of the standard stateless rule
    /// actions. For
    /// example, you could pair this in a rule action with the standard action that
    /// forwards the
    /// packet for stateful inspection. Then, when a packet matches the rule,
    /// Network Firewall
    /// publishes metrics for the packet and forwards it.
    publish_metric_action: ?PublishMetricAction,

    pub const json_field_names = .{
        .publish_metric_action = "PublishMetricAction",
    };
};
