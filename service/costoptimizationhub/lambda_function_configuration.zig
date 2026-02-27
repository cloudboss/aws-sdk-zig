const ComputeConfiguration = @import("compute_configuration.zig").ComputeConfiguration;

/// The Lambda function configuration used for recommendations.
pub const LambdaFunctionConfiguration = struct {
    /// Details about the compute configuration.
    compute: ?ComputeConfiguration,

    pub const json_field_names = .{
        .compute = "compute",
    };
};
