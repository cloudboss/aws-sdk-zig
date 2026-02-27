/// The monitoring configuration object you can configure to send metrics to
/// Amazon Managed Service for Prometheus for a job run.
pub const PrometheusMonitoringConfiguration = struct {
    /// The remote write URL in the Amazon Managed Service for Prometheus workspace
    /// to send metrics to.
    remote_write_url: ?[]const u8,

    pub const json_field_names = .{
        .remote_write_url = "remoteWriteUrl",
    };
};
