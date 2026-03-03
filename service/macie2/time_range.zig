const std = @import("std");

/// An inclusive time period that Amazon Macie usage data applies to. Possible
/// values are:
pub const TimeRange = enum {
    month_to_date,
    past_30_days,

    pub const json_field_names = .{
        .month_to_date = "MONTH_TO_DATE",
        .past_30_days = "PAST_30_DAYS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .month_to_date => "MONTH_TO_DATE",
            .past_30_days => "PAST_30_DAYS",
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
