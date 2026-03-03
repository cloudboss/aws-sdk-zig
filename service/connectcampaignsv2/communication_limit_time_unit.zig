const std = @import("std");

/// The communication limit time unit.
pub const CommunicationLimitTimeUnit = enum {
    day,

    pub const json_field_names = .{
        .day = "DAY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .day => "DAY",
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
