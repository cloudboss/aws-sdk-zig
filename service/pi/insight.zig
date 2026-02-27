const Data = @import("data.zig").Data;
const ContextType = @import("context_type.zig").ContextType;
const Recommendation = @import("recommendation.zig").Recommendation;
const Severity = @import("severity.zig").Severity;

/// Retrieves the list of performance issues which are identified.
pub const Insight = struct {
    /// Metric names and values from the timeframe
    /// used as baseline to generate the insight.
    baseline_data: ?[]const Data,

    /// Indicates if the insight is causal or correlated insight.
    context: ?ContextType,

    /// Description of the insight. For example:
    /// `A high severity Insight found between 02:00 to 02:30,
    /// where there was an unusually high DB load 600x above baseline.
    /// Likely performance impact`.
    description: ?[]const u8,

    /// The end time of the insight. For example, `2018-10-30T00:00:00Z`.
    end_time: ?i64,

    /// List of data objects containing metrics and references from the time range
    /// while generating the insight.
    insight_data: ?[]const Data,

    /// The unique identifier for the insight. For example,
    /// `insight-12345678901234567`.
    insight_id: []const u8,

    /// The type of insight. For example, `HighDBLoad`, `HighCPU`, or
    /// `DominatingSQLs`.
    insight_type: ?[]const u8,

    /// List of recommendations for the insight.
    /// For example, `Investigate the following SQLs that contributed
    /// to 100% of the total DBLoad during that time period: sql-id`.
    recommendations: ?[]const Recommendation,

    /// The severity of the insight. The values are: `Low`, `Medium`, or `High`.
    severity: ?Severity,

    /// The start time of the insight. For example, `2018-10-30T00:00:00Z`.
    start_time: ?i64,

    /// List of supporting insights that provide additional factors for the insight.
    supporting_insights: ?[]const Insight,

    pub const json_field_names = .{
        .baseline_data = "BaselineData",
        .context = "Context",
        .description = "Description",
        .end_time = "EndTime",
        .insight_data = "InsightData",
        .insight_id = "InsightId",
        .insight_type = "InsightType",
        .recommendations = "Recommendations",
        .severity = "Severity",
        .start_time = "StartTime",
        .supporting_insights = "SupportingInsights",
    };
};
