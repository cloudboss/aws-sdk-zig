const std = @import("std");

pub const ValidationExceptionReason = enum {
    invalid_agreement_id,
    missing_agreement_id,
    invalid_catalog,
    invalid_filter_name,
    invalid_filter_values,
    invalid_sort_by,
    invalid_sort_order,
    invalid_next_token,
    invalid_max_results,
    unsupported_filters,
    other,

    pub const json_field_names = .{
        .invalid_agreement_id = "INVALID_AGREEMENT_ID",
        .missing_agreement_id = "MISSING_AGREEMENT_ID",
        .invalid_catalog = "INVALID_CATALOG",
        .invalid_filter_name = "INVALID_FILTER_NAME",
        .invalid_filter_values = "INVALID_FILTER_VALUES",
        .invalid_sort_by = "INVALID_SORT_BY",
        .invalid_sort_order = "INVALID_SORT_ORDER",
        .invalid_next_token = "INVALID_NEXT_TOKEN",
        .invalid_max_results = "INVALID_MAX_RESULTS",
        .unsupported_filters = "UNSUPPORTED_FILTERS",
        .other = "OTHER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .invalid_agreement_id => "INVALID_AGREEMENT_ID",
            .missing_agreement_id => "MISSING_AGREEMENT_ID",
            .invalid_catalog => "INVALID_CATALOG",
            .invalid_filter_name => "INVALID_FILTER_NAME",
            .invalid_filter_values => "INVALID_FILTER_VALUES",
            .invalid_sort_by => "INVALID_SORT_BY",
            .invalid_sort_order => "INVALID_SORT_ORDER",
            .invalid_next_token => "INVALID_NEXT_TOKEN",
            .invalid_max_results => "INVALID_MAX_RESULTS",
            .unsupported_filters => "UNSUPPORTED_FILTERS",
            .other => "OTHER",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
