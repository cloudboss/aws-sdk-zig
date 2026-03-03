const aws = @import("aws");

/// A pillar review summary of a lens review.
pub const PillarReviewSummary = struct {
    notes: ?[]const u8 = null,

    pillar_id: ?[]const u8 = null,

    pillar_name: ?[]const u8 = null,

    prioritized_risk_counts: ?[]const aws.map.MapEntry(i32) = null,

    risk_counts: ?[]const aws.map.MapEntry(i32) = null,

    pub const json_field_names = .{
        .notes = "Notes",
        .pillar_id = "PillarId",
        .pillar_name = "PillarName",
        .prioritized_risk_counts = "PrioritizedRiskCounts",
        .risk_counts = "RiskCounts",
    };
};
