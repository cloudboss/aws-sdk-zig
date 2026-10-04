const std = @import("std");

pub const RepeatCadence = enum {
    one_time,
    weekly,
    monthly,
    yearly,

    pub const json_field_names = .{
        .one_time = "ONE_TIME",
        .weekly = "WEEKLY",
        .monthly = "MONTHLY",
        .yearly = "YEARLY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .one_time => "ONE_TIME",
            .weekly => "WEEKLY",
            .monthly => "MONTHLY",
            .yearly => "YEARLY",
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
