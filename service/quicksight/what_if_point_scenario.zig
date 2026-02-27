/// Provides the forecast to meet the target for a particular date.
pub const WhatIfPointScenario = struct {
    /// The date that you need the forecast results for.
    date: i64,

    /// The target value that you want to meet for the provided date.
    value: f64 = 0,

    pub const json_field_names = .{
        .date = "Date",
        .value = "Value",
    };
};
