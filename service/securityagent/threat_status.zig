const std = @import("std");

/// Status of a threat.
pub const ThreatStatus = enum {
    open,
    resolved,
    dismissed,

    pub const json_field_names = .{
        .open = "OPEN",
        .resolved = "RESOLVED",
        .dismissed = "DISMISSED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .open => "OPEN",
            .resolved => "RESOLVED",
            .dismissed => "DISMISSED",
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
