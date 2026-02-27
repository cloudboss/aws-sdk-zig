/// Entity that comprises information of count and percentage.
pub const CountPercent = struct {
    /// Indicates the count of occurences of the given statistic.
    count: i32,

    /// Indicates the percentage of occurances of the given statistic.
    percentage: f32 = 0,

    pub const json_field_names = .{
        .count = "Count",
        .percentage = "Percentage",
    };
};
