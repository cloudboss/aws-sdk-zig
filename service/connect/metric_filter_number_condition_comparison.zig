const std = @import("std");

/// The numeric comparison operator for metric filters. Valid values: `LESSER` |
/// `LESSER_OR_EQUAL` | `GREATER` | `GREATER_OR_EQUAL`.
pub const MetricFilterNumberConditionComparison = enum {
    lesser,
    lesser_or_equal,
    greater,
    greater_or_equal,

    pub const json_field_names = .{
        .lesser = "LESSER",
        .lesser_or_equal = "LESSER_OR_EQUAL",
        .greater = "GREATER",
        .greater_or_equal = "GREATER_OR_EQUAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .lesser => "LESSER",
            .lesser_or_equal => "LESSER_OR_EQUAL",
            .greater => "GREATER",
            .greater_or_equal => "GREATER_OR_EQUAL",
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
