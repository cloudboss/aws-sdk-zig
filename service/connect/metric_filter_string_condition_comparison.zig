const std = @import("std");

/// The string comparison operator for metric filters. Valid values:
/// `MATCHES_ANY` | `MATCHES_NONE`.
pub const MetricFilterStringConditionComparison = enum {
    matches_any,
    matches_none,

    pub const json_field_names = .{
        .matches_any = "MATCHES_ANY",
        .matches_none = "MATCHES_NONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .matches_any => "MATCHES_ANY",
            .matches_none => "MATCHES_NONE",
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
