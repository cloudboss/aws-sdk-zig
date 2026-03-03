const InstanceSavingsEstimationModeSource = @import("instance_savings_estimation_mode_source.zig").InstanceSavingsEstimationModeSource;

/// Describes the savings estimation mode used for calculating savings
/// opportunity for Amazon EC2 instances.
pub const InstanceSavingsEstimationMode = struct {
    /// Describes the source for calculating the savings opportunity for Amazon EC2
    /// instances.
    source: ?InstanceSavingsEstimationModeSource = null,

    pub const json_field_names = .{
        .source = "source",
    };
};
