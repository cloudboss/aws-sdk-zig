const std = @import("std");

pub const CostFrequency = enum {
    hourly,
    daily,
    monthly,
    yearly,

    pub const json_field_names = .{
        .hourly = "Hourly",
        .daily = "Daily",
        .monthly = "Monthly",
        .yearly = "Yearly",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .hourly => "Hourly",
            .daily => "Daily",
            .monthly => "Monthly",
            .yearly => "Yearly",
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
