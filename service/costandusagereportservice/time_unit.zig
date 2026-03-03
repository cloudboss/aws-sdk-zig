const std = @import("std");

/// The length of time covered by the report.
pub const TimeUnit = enum {
    hourly,
    daily,
    monthly,

    pub const json_field_names = .{
        .hourly = "HOURLY",
        .daily = "DAILY",
        .monthly = "MONTHLY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .hourly => "HOURLY",
            .daily => "DAILY",
            .monthly => "MONTHLY",
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
