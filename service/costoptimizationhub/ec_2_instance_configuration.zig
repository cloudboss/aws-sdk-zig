const InstanceConfiguration = @import("instance_configuration.zig").InstanceConfiguration;

/// The EC2 instance configuration used for recommendations.
pub const Ec2InstanceConfiguration = struct {
    /// Details about the instance.
    instance: ?InstanceConfiguration = null,

    pub const json_field_names = .{
        .instance = "instance",
    };
};
