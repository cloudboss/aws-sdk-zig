const AssessmentRiskRecommendation = @import("assessment_risk_recommendation.zig").AssessmentRiskRecommendation;

/// Indicates the AI-generated summary for the Resilience Hub assessment,
/// providing a concise overview that highlights the top risks and
/// recommendations.
///
/// This property is available only in the US East (N. Virginia) Region.
pub const AssessmentSummary = struct {
    /// Indicates the top risks and recommendations identified by the Resilience Hub
    /// assessment,
    /// each representing a specific risk and the corresponding recommendation to
    /// address it.
    ///
    /// This property is available only in the US East (N. Virginia) Region.
    risk_recommendations: ?[]const AssessmentRiskRecommendation,

    /// Indicates a concise summary that provides an overview of the Resilience Hub
    /// assessment.
    ///
    /// This property is available only in the US East (N. Virginia) Region.
    summary: ?[]const u8,

    pub const json_field_names = .{
        .risk_recommendations = "riskRecommendations",
        .summary = "summary",
    };
};
