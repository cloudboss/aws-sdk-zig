const VpcConfig = @import("vpc_config.zig").VpcConfig;

/// Run-specific configuration settings.
pub const RunConfigurations = struct {
    /// VPC configuration for workflow runs.
    vpc_config: ?VpcConfig = null,

    pub const json_field_names = .{
        .vpc_config = "vpcConfig",
    };
};
