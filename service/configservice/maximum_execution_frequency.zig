const std = @import("std");

pub const MaximumExecutionFrequency = enum {
    one_hour,
    three_hours,
    six_hours,
    twelve_hours,
    twenty_four_hours,

    pub const json_field_names = .{
        .one_hour = "One_Hour",
        .three_hours = "Three_Hours",
        .six_hours = "Six_Hours",
        .twelve_hours = "Twelve_Hours",
        .twenty_four_hours = "TwentyFour_Hours",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .one_hour => "One_Hour",
            .three_hours => "Three_Hours",
            .six_hours => "Six_Hours",
            .twelve_hours => "Twelve_Hours",
            .twenty_four_hours => "TwentyFour_Hours",
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
