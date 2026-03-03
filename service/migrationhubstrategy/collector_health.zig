const std = @import("std");

pub const CollectorHealth = enum {
    collector_healthy,
    collector_unhealthy,

    pub const json_field_names = .{
        .collector_healthy = "COLLECTOR_HEALTHY",
        .collector_unhealthy = "COLLECTOR_UNHEALTHY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .collector_healthy => "COLLECTOR_HEALTHY",
            .collector_unhealthy => "COLLECTOR_UNHEALTHY",
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
