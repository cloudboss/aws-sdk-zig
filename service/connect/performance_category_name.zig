const std = @import("std");

pub const PerformanceCategoryName = enum {
    needs_improvement,
    exceeds_expectations,

    pub const json_field_names = .{
        .needs_improvement = "NEEDS_IMPROVEMENT",
        .exceeds_expectations = "EXCEEDS_EXPECTATIONS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .needs_improvement => "NEEDS_IMPROVEMENT",
            .exceeds_expectations => "EXCEEDS_EXPECTATIONS",
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
