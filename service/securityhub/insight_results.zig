const InsightResultValue = @import("insight_result_value.zig").InsightResultValue;

/// The insight results returned by the `GetInsightResults` operation.
pub const InsightResults = struct {
    /// The attribute that the findings are grouped by for the insight whose results
    /// are
    /// returned by the `GetInsightResults` operation.
    group_by_attribute: []const u8,

    /// The ARN of the insight whose results are returned by the `GetInsightResults`
    /// operation.
    insight_arn: []const u8,

    /// The list of insight result values returned by the `GetInsightResults`
    /// operation.
    result_values: []const InsightResultValue,

    pub const json_field_names = .{
        .group_by_attribute = "GroupByAttribute",
        .insight_arn = "InsightArn",
        .result_values = "ResultValues",
    };
};
