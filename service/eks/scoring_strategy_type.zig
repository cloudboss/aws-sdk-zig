const std = @import("std");

/// The scoring strategy type for the NodeResourcesFit scheduler plugin.
pub const ScoringStrategyType = enum {
    least_allocated,
    most_allocated,

    pub const json_field_names = .{
        .least_allocated = "LeastAllocated",
        .most_allocated = "MostAllocated",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .least_allocated => "LeastAllocated",
            .most_allocated => "MostAllocated",
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
