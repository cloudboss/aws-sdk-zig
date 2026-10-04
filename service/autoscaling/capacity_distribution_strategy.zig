const std = @import("std");

pub const CapacityDistributionStrategy = enum {
    balanced_only,
    balanced_best_effort,
    reservations_then_balanced,

    pub const json_field_names = .{
        .balanced_only = "balanced-only",
        .balanced_best_effort = "balanced-best-effort",
        .reservations_then_balanced = "reservations-then-balanced",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .balanced_only => "balanced-only",
            .balanced_best_effort => "balanced-best-effort",
            .reservations_then_balanced => "reservations-then-balanced",
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
