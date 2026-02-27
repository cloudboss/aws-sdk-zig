const RDSSavingsEstimationModeSource = @import("rds_savings_estimation_mode_source.zig").RDSSavingsEstimationModeSource;

/// Describes the savings estimation mode used for calculating savings
/// opportunity for DB instances.
pub const RDSSavingsEstimationMode = struct {
    /// Describes the source for calculating the savings opportunity for DB
    /// instances.
    source: ?RDSSavingsEstimationModeSource,

    pub const json_field_names = .{
        .source = "source",
    };
};
