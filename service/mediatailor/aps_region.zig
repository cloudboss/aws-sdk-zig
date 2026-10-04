const std = @import("std");

/// Supported Amazon Publisher Services regions for yield optimization
/// integration. The region selection affects latency and ad inventory
/// availability, so choose the region closest to your primary audience.
pub const ApsRegion = enum {
    americas,
    europe,
    asia_pacific,

    pub const json_field_names = .{
        .americas = "AMERICAS",
        .europe = "EUROPE",
        .asia_pacific = "ASIA_PACIFIC",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .americas => "AMERICAS",
            .europe => "EUROPE",
            .asia_pacific => "ASIA_PACIFIC",
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
