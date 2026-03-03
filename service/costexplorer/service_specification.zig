const EC2Specification = @import("ec2_specification.zig").EC2Specification;

/// Hardware specifications for the service that you want recommendations for.
pub const ServiceSpecification = struct {
    /// The Amazon EC2 hardware specifications that you want Amazon Web Services to
    /// provide
    /// recommendations for.
    ec2_specification: ?EC2Specification = null,

    pub const json_field_names = .{
        .ec2_specification = "EC2Specification",
    };
};
