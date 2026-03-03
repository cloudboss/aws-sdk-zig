const std = @import("std");

pub const CapacityDistributionStrategy = enum {
    balanced_only,
    balanced_best_effort,

    pub const json_field_names = .{
        .balanced_only = "balanced-only",
        .balanced_best_effort = "balanced-best-effort",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .balanced_only => "balanced-only",
            .balanced_best_effort => "balanced-best-effort",
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
