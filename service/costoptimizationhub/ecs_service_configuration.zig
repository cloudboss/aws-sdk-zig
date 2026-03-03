const ComputeConfiguration = @import("compute_configuration.zig").ComputeConfiguration;

/// The ECS service configuration used for recommendations.
pub const EcsServiceConfiguration = struct {
    /// Details about the compute configuration.
    compute: ?ComputeConfiguration = null,

    pub const json_field_names = .{
        .compute = "compute",
    };
};
