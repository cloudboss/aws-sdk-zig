/// Describes the performance risk ratings for a given resource type.
///
/// Resources with a `high` or `medium` rating are at risk of not
/// meeting the performance needs of their workloads, while resources with a
/// `low` rating are performing well in their workloads.
pub const CurrentPerformanceRiskRatings = struct {
    /// A count of the applicable resource types with a high performance risk
    /// rating.
    high: i64 = 0,

    /// A count of the applicable resource types with a low performance risk rating.
    low: i64 = 0,

    /// A count of the applicable resource types with a medium performance risk
    /// rating.
    medium: i64 = 0,

    /// A count of the applicable resource types with a very low performance risk
    /// rating.
    very_low: i64 = 0,

    pub const json_field_names = .{
        .high = "high",
        .low = "low",
        .medium = "medium",
        .very_low = "veryLow",
    };
};
