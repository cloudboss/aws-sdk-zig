const Ec2Configuration = @import("ec_2_configuration.zig").Ec2Configuration;

/// The compute configuration for a capacity provider. This structure defines
/// the type and settings of the compute resources used to launch instances.
pub const ComputeConfiguration = union(enum) {
    /// The Amazon EC2 compute configuration for the capacity provider.
    ec_2_configuration: ?Ec2Configuration,

    pub const json_field_names = .{
        .ec_2_configuration = "ec2Configuration",
    };
};
