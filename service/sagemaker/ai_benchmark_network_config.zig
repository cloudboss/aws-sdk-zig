const VpcConfig = @import("vpc_config.zig").VpcConfig;

/// The network configuration for an AI benchmark job.
pub const AIBenchmarkNetworkConfig = struct {
    /// The VPC configuration, including security group IDs and subnet IDs.
    vpc_config: ?VpcConfig = null,

    pub const json_field_names = .{
        .vpc_config = "VpcConfig",
    };
};
