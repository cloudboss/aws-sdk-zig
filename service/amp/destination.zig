const AmpConfiguration = @import("amp_configuration.zig").AmpConfiguration;

/// Where to send the metrics from a scraper.
pub const Destination = union(enum) {
    /// The Amazon Managed Service for Prometheus workspace to send metrics to.
    amp_configuration: ?AmpConfiguration,

    pub const json_field_names = .{
        .amp_configuration = "ampConfiguration",
    };
};
