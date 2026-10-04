const std = @import("std");

/// Time-to-live duration for ephemeral cache entries
pub const CacheTTL = enum {
    five_minutes,
    one_hour,

    pub const json_field_names = .{
        .five_minutes = "5m",
        .one_hour = "1h",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .five_minutes => "5m",
            .one_hour => "1h",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
