const std = @import("std");

/// Eac3 Passthrough Control
pub const Eac3PassthroughControl = enum {
    no_passthrough,
    when_possible,

    pub const json_field_names = .{
        .no_passthrough = "NO_PASSTHROUGH",
        .when_possible = "WHEN_POSSIBLE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .no_passthrough => "NO_PASSTHROUGH",
            .when_possible => "WHEN_POSSIBLE",
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
