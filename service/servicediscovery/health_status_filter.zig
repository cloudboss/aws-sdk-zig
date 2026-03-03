const std = @import("std");

pub const HealthStatusFilter = enum {
    healthy,
    unhealthy,
    all,
    healthy_or_else_all,

    pub const json_field_names = .{
        .healthy = "HEALTHY",
        .unhealthy = "UNHEALTHY",
        .all = "ALL",
        .healthy_or_else_all = "HEALTHY_OR_ELSE_ALL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .healthy => "HEALTHY",
            .unhealthy => "UNHEALTHY",
            .all => "ALL",
            .healthy_or_else_all => "HEALTHY_OR_ELSE_ALL",
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
