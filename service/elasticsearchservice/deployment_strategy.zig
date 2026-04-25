const std = @import("std");

/// Specifies the deployment strategy for the domain. Valid values are `Default`
/// and `CapacityOptimized`.
pub const DeploymentStrategy = enum {
    default,
    capacity_optimized,

    pub const json_field_names = .{
        .default = "Default",
        .capacity_optimized = "CapacityOptimized",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .default => "Default",
            .capacity_optimized => "CapacityOptimized",
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
