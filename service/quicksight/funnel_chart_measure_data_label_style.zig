pub const FunnelChartMeasureDataLabelStyle = enum {
    value_only,
    percentage_by_first_stage,
    percentage_by_previous_stage,
    value_and_percentage_by_first_stage,
    value_and_percentage_by_previous_stage,

    pub const json_field_names = .{
        .value_only = "VALUE_ONLY",
        .percentage_by_first_stage = "PERCENTAGE_BY_FIRST_STAGE",
        .percentage_by_previous_stage = "PERCENTAGE_BY_PREVIOUS_STAGE",
        .value_and_percentage_by_first_stage = "VALUE_AND_PERCENTAGE_BY_FIRST_STAGE",
        .value_and_percentage_by_previous_stage = "VALUE_AND_PERCENTAGE_BY_PREVIOUS_STAGE",
    };
};
