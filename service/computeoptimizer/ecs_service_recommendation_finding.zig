const std = @import("std");

pub const ECSServiceRecommendationFinding = enum {
    optimized,
    under_provisioned,
    over_provisioned,

    pub const json_field_names = .{
        .optimized = "Optimized",
        .under_provisioned = "Underprovisioned",
        .over_provisioned = "Overprovisioned",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .optimized => "Optimized",
            .under_provisioned => "Underprovisioned",
            .over_provisioned => "Overprovisioned",
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
