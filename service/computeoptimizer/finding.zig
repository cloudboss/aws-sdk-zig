const std = @import("std");

pub const Finding = enum {
    under_provisioned,
    over_provisioned,
    optimized,
    not_optimized,

    pub const json_field_names = .{
        .under_provisioned = "Underprovisioned",
        .over_provisioned = "Overprovisioned",
        .optimized = "Optimized",
        .not_optimized = "NotOptimized",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .under_provisioned => "Underprovisioned",
            .over_provisioned => "Overprovisioned",
            .optimized => "Optimized",
            .not_optimized => "NotOptimized",
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
