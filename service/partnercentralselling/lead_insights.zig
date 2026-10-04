/// Contains insights that AI generates for a lead. These insights provide
/// automated analysis to help partners evaluate the lead quality and prioritize
/// engagement efforts.
pub const LeadInsights = struct {
    /// A score that indicates the lead's readiness for engagement. Valid values are
    /// `Low`, `Medium`, and `High`. Use this score to prioritize leads based on
    /// their likelihood of conversion.
    lead_readiness_score: ?[]const u8 = null,

    pub const json_field_names = .{
        .lead_readiness_score = "LeadReadinessScore",
    };
};
