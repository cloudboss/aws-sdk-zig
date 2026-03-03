const RdsRecommendation = @import("rds_recommendation.zig").RdsRecommendation;

/// Provides information about the target engine for the specified source
/// database.
pub const RecommendationData = struct {
    /// The recommendation of a target Amazon RDS database engine.
    rds_engine: ?RdsRecommendation = null,

    pub const json_field_names = .{
        .rds_engine = "RdsEngine",
    };
};
