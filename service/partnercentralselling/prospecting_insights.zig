/// Contains insights that AI generates from the prospecting analysis. These
/// insights include marketplace engagement scoring, solution fit assessments,
/// and solution categorization for the prospected customer.
pub const ProspectingInsights = struct {
    /// A score that indicates the prospected customer's level of engagement with
    /// AWS Marketplace. Valid values are `High`, `Medium`, and `Low`.
    marketplace_engagement_score: ?[]const u8 = null,

    /// The primary solution category classification for the prospected customer.
    /// This indicates the type of solution that best addresses their needs.
    solution_category: ?[]const u8 = null,

    /// A score that indicates how well the partner's solution fits the prospected
    /// customer's needs.
    solution_score: ?[]const u8 = null,

    /// The solution sub-category classification for the prospected customer. This
    /// provides more granular categorization of the recommended solution type.
    solution_sub_category: ?[]const u8 = null,

    pub const json_field_names = .{
        .marketplace_engagement_score = "MarketplaceEngagementScore",
        .solution_category = "SolutionCategory",
        .solution_score = "SolutionScore",
        .solution_sub_category = "SolutionSubCategory",
    };
};
