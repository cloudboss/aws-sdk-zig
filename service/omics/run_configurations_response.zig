const VpcConfigResponse = @import("vpc_config_response.zig").VpcConfigResponse;

/// Run-specific configuration settings with computed values.
pub const RunConfigurationsResponse = struct {
    /// VPC configuration for workflow runs with computed VPC ID.
    vpc_config: ?VpcConfigResponse = null,

    pub const json_field_names = .{
        .vpc_config = "vpcConfig",
    };
};
