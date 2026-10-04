const AmpConfiguration = @import("amp_configuration.zig").AmpConfiguration;
const CloudWatchConfiguration = @import("cloud_watch_configuration.zig").CloudWatchConfiguration;

/// Where to send the metrics from a scraper.
pub const Destination = union(enum) {
    /// The Amazon Managed Service for Prometheus workspace to send metrics to.
    amp_configuration: ?AmpConfiguration,
    /// The CloudWatch dataset to send metrics to.
    cloud_watch_configuration: ?CloudWatchConfiguration,

    pub const json_field_names = .{
        .amp_configuration = "ampConfiguration",
        .cloud_watch_configuration = "cloudWatchConfiguration",
    };
};
