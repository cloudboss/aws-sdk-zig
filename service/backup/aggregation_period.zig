const std = @import("std");

pub const AggregationPeriod = enum {
    one_day,
    seven_days,
    fourteen_days,

    pub const json_field_names = .{
        .one_day = "ONE_DAY",
        .seven_days = "SEVEN_DAYS",
        .fourteen_days = "FOURTEEN_DAYS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .one_day => "ONE_DAY",
            .seven_days => "SEVEN_DAYS",
            .fourteen_days => "FOURTEEN_DAYS",
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
