const std = @import("std");

pub const MonthName = enum {
    january,
    february,
    march,
    april,
    may,
    june,
    july,
    august,
    september,
    october,
    november,
    december,

    pub const json_field_names = .{
        .january = "JANUARY",
        .february = "FEBRUARY",
        .march = "MARCH",
        .april = "APRIL",
        .may = "MAY",
        .june = "JUNE",
        .july = "JULY",
        .august = "AUGUST",
        .september = "SEPTEMBER",
        .october = "OCTOBER",
        .november = "NOVEMBER",
        .december = "DECEMBER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .january => "JANUARY",
            .february => "FEBRUARY",
            .march => "MARCH",
            .april => "APRIL",
            .may => "MAY",
            .june => "JUNE",
            .july => "JULY",
            .august => "AUGUST",
            .september => "SEPTEMBER",
            .october => "OCTOBER",
            .november => "NOVEMBER",
            .december => "DECEMBER",
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
