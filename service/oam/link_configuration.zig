const LogGroupConfiguration = @import("log_group_configuration.zig").LogGroupConfiguration;
const MetricConfiguration = @import("metric_configuration.zig").MetricConfiguration;

/// Use this structure to optionally create filters that specify that only some
/// metric namespaces or log groups are to be shared from the source account to
/// the monitoring account.
pub const LinkConfiguration = struct {
    /// Use this structure to filter which log groups are to send log events from
    /// the source account to the monitoring account.
    log_group_configuration: ?LogGroupConfiguration = null,

    /// Use this structure to filter which metric namespaces are to be shared from
    /// the source account to the monitoring account.
    metric_configuration: ?MetricConfiguration = null,

    pub const json_field_names = .{
        .log_group_configuration = "LogGroupConfiguration",
        .metric_configuration = "MetricConfiguration",
    };
};
