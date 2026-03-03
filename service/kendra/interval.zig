const std = @import("std");

pub const Interval = enum {
    this_month,
    this_week,
    one_week_ago,
    two_weeks_ago,
    one_month_ago,
    two_months_ago,

    pub const json_field_names = .{
        .this_month = "THIS_MONTH",
        .this_week = "THIS_WEEK",
        .one_week_ago = "ONE_WEEK_AGO",
        .two_weeks_ago = "TWO_WEEKS_AGO",
        .one_month_ago = "ONE_MONTH_AGO",
        .two_months_ago = "TWO_MONTHS_AGO",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .this_month => "THIS_MONTH",
            .this_week => "THIS_WEEK",
            .one_week_ago => "ONE_WEEK_AGO",
            .two_weeks_ago => "TWO_WEEKS_AGO",
            .one_month_ago => "ONE_MONTH_AGO",
            .two_months_ago => "TWO_MONTHS_AGO",
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
