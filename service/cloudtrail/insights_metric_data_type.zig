pub const InsightsMetricDataType = enum {
    fill_with_zeros,
    non_zero_data,

    pub const json_field_names = .{
        .fill_with_zeros = "FILL_WITH_ZEROS",
        .non_zero_data = "NON_ZERO_DATA",
    };
};
