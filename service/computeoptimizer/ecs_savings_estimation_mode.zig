const ECSSavingsEstimationModeSource = @import("ecs_savings_estimation_mode_source.zig").ECSSavingsEstimationModeSource;

/// Describes the savings estimation mode used for calculating savings
/// opportunity for Amazon ECS services.
pub const ECSSavingsEstimationMode = struct {
    /// Describes the source for calculating the savings opportunity for Amazon ECS
    /// services.
    source: ?ECSSavingsEstimationModeSource,

    pub const json_field_names = .{
        .source = "source",
    };
};
