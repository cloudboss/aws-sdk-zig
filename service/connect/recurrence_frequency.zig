const std = @import("std");

pub const RecurrenceFrequency = enum {
    weekly,
    monthly,
    yearly,

    pub const json_field_names = .{
        .weekly = "WEEKLY",
        .monthly = "MONTHLY",
        .yearly = "YEARLY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
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
