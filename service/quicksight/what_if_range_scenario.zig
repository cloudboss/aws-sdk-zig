/// Provides the forecast to meet the target for a particular date range.
pub const WhatIfRangeScenario = struct {
    /// The end date in the date range that you need the forecast results for.
    end_date: i64,

    /// The start date in the date range that you need the forecast results for.
    start_date: i64,

    /// The target value that you want to meet for the provided date range.
    value: f64 = 0,

    pub const json_field_names = .{
        .end_date = "EndDate",
        .start_date = "StartDate",
        .value = "Value",
    };
};
