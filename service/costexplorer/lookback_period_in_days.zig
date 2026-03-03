const std = @import("std");

pub const LookbackPeriodInDays = enum {
    seven_days,
    thirty_days,
    sixty_days,

    pub const json_field_names = .{
        .seven_days = "SEVEN_DAYS",
        .thirty_days = "THIRTY_DAYS",
        .sixty_days = "SIXTY_DAYS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .seven_days => "SEVEN_DAYS",
            .thirty_days => "THIRTY_DAYS",
            .sixty_days => "SIXTY_DAYS",
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
