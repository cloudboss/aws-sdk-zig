pub const SearchOutputAdditionalAttribute = enum {
    forms,
    time_series_data_point_forms,
    text_match_rationale,

    pub const json_field_names = .{
        .forms = "FORMS",
        .time_series_data_point_forms = "TIME_SERIES_DATA_POINT_FORMS",
        .text_match_rationale = "TEXT_MATCH_RATIONALE",
    };
};
