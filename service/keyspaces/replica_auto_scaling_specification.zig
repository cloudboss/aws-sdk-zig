const AutoScalingSpecification = @import("auto_scaling_specification.zig").AutoScalingSpecification;

/// The auto scaling settings of a multi-Region table in the specified Amazon
/// Web Services Region.
pub const ReplicaAutoScalingSpecification = struct {
    /// The auto scaling settings for a multi-Region table in the specified Amazon
    /// Web Services Region.
    auto_scaling_specification: ?AutoScalingSpecification = null,

    /// The Amazon Web Services Region.
    region: ?[]const u8 = null,

    pub const json_field_names = .{
        .auto_scaling_specification = "autoScalingSpecification",
        .region = "region",
    };
};
