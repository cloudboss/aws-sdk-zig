const EBSSavingsEstimationModeSource = @import("ebs_savings_estimation_mode_source.zig").EBSSavingsEstimationModeSource;

/// Describes the savings estimation mode used for calculating savings
/// opportunity for Amazon EBS volumes.
pub const EBSSavingsEstimationMode = struct {
    /// Describes the source for calculating the savings opportunity for Amazon EBS
    /// volumes.
    source: ?EBSSavingsEstimationModeSource,

    pub const json_field_names = .{
        .source = "source",
    };
};
