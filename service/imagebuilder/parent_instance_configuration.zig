const AutoScalingGroupConfiguration = @import("auto_scaling_group_configuration.zig").AutoScalingGroupConfiguration;

/// Settings for building on an instance that is already running, instead of an
/// instance that Image Builder launches for the build.
pub const ParentInstanceConfiguration = struct {
    /// The Amazon EC2 Auto Scaling group that Image Builder takes the build
    /// instance from. This is
    /// required when you specify `parentInstance`.
    auto_scaling_group: AutoScalingGroupConfiguration,

    pub const json_field_names = .{
        .auto_scaling_group = "autoScalingGroup",
    };
};
