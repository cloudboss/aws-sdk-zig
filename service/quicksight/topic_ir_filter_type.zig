const std = @import("std");

pub const TopicIRFilterType = enum {
    category_filter,
    numeric_equality_filter,
    numeric_range_filter,
    date_range_filter,
    relative_date_filter,
    top_bottom_filter,
    equals,
    rank_limit_filter,
    accept_all_filter,

    pub const json_field_names = .{
        .category_filter = "CATEGORY_FILTER",
        .numeric_equality_filter = "NUMERIC_EQUALITY_FILTER",
        .numeric_range_filter = "NUMERIC_RANGE_FILTER",
        .date_range_filter = "DATE_RANGE_FILTER",
        .relative_date_filter = "RELATIVE_DATE_FILTER",
        .top_bottom_filter = "TOP_BOTTOM_FILTER",
        .equals = "EQUALS",
        .rank_limit_filter = "RANK_LIMIT_FILTER",
        .accept_all_filter = "ACCEPT_ALL_FILTER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .category_filter => "CATEGORY_FILTER",
            .numeric_equality_filter => "NUMERIC_EQUALITY_FILTER",
            .numeric_range_filter => "NUMERIC_RANGE_FILTER",
            .date_range_filter => "DATE_RANGE_FILTER",
            .relative_date_filter => "RELATIVE_DATE_FILTER",
            .top_bottom_filter => "TOP_BOTTOM_FILTER",
            .equals => "EQUALS",
            .rank_limit_filter => "RANK_LIMIT_FILTER",
            .accept_all_filter => "ACCEPT_ALL_FILTER",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
