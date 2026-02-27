/// The insight result values returned by the `GetInsightResults`
/// operation.
pub const InsightResultValue = struct {
    /// The number of findings returned for each `GroupByAttributeValue`.
    count: i32,

    /// The value of the attribute that the findings are grouped by for the insight
    /// whose
    /// results are returned by the `GetInsightResults` operation.
    group_by_attribute_value: []const u8,

    pub const json_field_names = .{
        .count = "Count",
        .group_by_attribute_value = "GroupByAttributeValue",
    };
};
