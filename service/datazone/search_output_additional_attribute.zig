const std = @import("std");

pub const SearchOutputAdditionalAttribute = enum {
    forms,
    time_series_data_point_forms,
    text_match_rationale,

    pub const json_field_names = .{
        .forms = "FORMS",
        .time_series_data_point_forms = "TIME_SERIES_DATA_POINT_FORMS",
        .text_match_rationale = "TEXT_MATCH_RATIONALE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .forms => "FORMS",
            .time_series_data_point_forms => "TIME_SERIES_DATA_POINT_FORMS",
            .text_match_rationale => "TEXT_MATCH_RATIONALE",
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
