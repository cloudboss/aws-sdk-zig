const VpcConfig = @import("vpc_config.zig").VpcConfig;

/// The networking configuration for the monitoring job.
pub const MonitoringNetworkConfig = struct {
    /// Whether to encrypt all communications between the instances used for the
    /// monitoring jobs. Choose `True` to encrypt communications. Encryption
    /// provides greater security for distributed jobs, but the processing might
    /// take longer.
    enable_inter_container_traffic_encryption: ?bool = null,

    /// Whether to allow inbound and outbound network calls to and from the
    /// containers used for the monitoring job.
    enable_network_isolation: ?bool = null,

    vpc_config: ?VpcConfig = null,

    pub const json_field_names = .{
        .enable_inter_container_traffic_encryption = "EnableInterContainerTrafficEncryption",
        .enable_network_isolation = "EnableNetworkIsolation",
        .vpc_config = "VpcConfig",
    };
};
