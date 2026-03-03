const VpcConfig = @import("vpc_config.zig").VpcConfig;

/// Networking options for a job, such as network traffic encryption between
/// containers, whether to allow inbound and outbound network calls to and from
/// containers, and the VPC subnets and security groups to use for VPC-enabled
/// jobs.
pub const NetworkConfig = struct {
    /// Whether to encrypt all communications between distributed processing jobs.
    /// Choose `True` to encrypt communications. Encryption provides greater
    /// security for distributed processing jobs, but the processing might take
    /// longer.
    enable_inter_container_traffic_encryption: ?bool = null,

    /// Whether to allow inbound and outbound network calls to and from the
    /// containers used for the processing job.
    enable_network_isolation: ?bool = null,

    vpc_config: ?VpcConfig = null,

    pub const json_field_names = .{
        .enable_inter_container_traffic_encryption = "EnableInterContainerTrafficEncryption",
        .enable_network_isolation = "EnableNetworkIsolation",
        .vpc_config = "VpcConfig",
    };
};
