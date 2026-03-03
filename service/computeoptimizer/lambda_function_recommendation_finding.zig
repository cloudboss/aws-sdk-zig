const std = @import("std");

pub const LambdaFunctionRecommendationFinding = enum {
    optimized,
    not_optimized,
    unavailable,

    pub const json_field_names = .{
        .optimized = "Optimized",
        .not_optimized = "NotOptimized",
        .unavailable = "Unavailable",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .optimized => "Optimized",
            .not_optimized => "NotOptimized",
            .unavailable => "Unavailable",
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
