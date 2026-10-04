const std = @import("std");

pub const ConcurrencyMode = enum {
    strict_failure_tolerance,
    soft_failure_tolerance,

    pub const json_field_names = .{
        .strict_failure_tolerance = "STRICT_FAILURE_TOLERANCE",
        .soft_failure_tolerance = "SOFT_FAILURE_TOLERANCE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .strict_failure_tolerance => "STRICT_FAILURE_TOLERANCE",
            .soft_failure_tolerance => "SOFT_FAILURE_TOLERANCE",
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
