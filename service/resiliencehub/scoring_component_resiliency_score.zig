/// Resiliency score of each scoring component. For more information about
/// scoring component,
/// see [Calculating resiliency
/// score](https://docs.aws.amazon.com/resilience-hub/latest/userguide/calculate-score.html).
pub const ScoringComponentResiliencyScore = struct {
    /// Number of recommendations that were excluded from the assessment.
    ///
    /// For example, if the `excludedCount` for Alarms coverage scoring component is
    /// 7,
    /// it indicates that 7 Amazon CloudWatch alarms are excluded from the
    /// assessment.
    excluded_count: i64 = 0,

    /// Number of recommendations that must be implemented to obtain the maximum
    /// possible score
    /// for the scoring component. For SOPs, alarms, and tests, these are the number
    /// of
    /// recommendations that must be implemented. For compliance, these are the
    /// number of Application
    /// Components that have breached the resiliency policy.
    ///
    /// For example, if the `outstandingCount` for Alarms coverage scoring component
    /// is
    /// 5, it indicates that 5 Amazon CloudWatch alarms need to be implemented to
    /// achieve the
    /// maximum possible score.
    outstanding_count: i64 = 0,

    /// Maximum possible score that can be obtained for the scoring component.
    ///
    /// For example, if the `possibleScore` is 20 points, it indicates the maximum
    /// possible score you can achieve for the scoring component when you run a new
    /// assessment after
    /// implementing all the Resilience Hub recommendations.
    possible_score: f64 = 0,

    /// Resiliency score points given for the scoring component. The score is always
    /// less than or
    /// equal to the `possibleScore`.
    score: f64 = 0,

    pub const json_field_names = .{
        .excluded_count = "excludedCount",
        .outstanding_count = "outstandingCount",
        .possible_score = "possibleScore",
        .score = "score",
    };
};
