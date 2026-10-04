const std = @import("std");

/// The boolean comparison operator for metric filters. Valid values: `IS_TRUE`
/// | `IS_FALSE`.
pub const MetricFilterBooleanConditionComparison = enum {
    is_true,
    is_false,

    pub const json_field_names = .{
        .is_true = "IS_TRUE",
        .is_false = "IS_FALSE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .is_true => "IS_TRUE",
            .is_false => "IS_FALSE",
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
