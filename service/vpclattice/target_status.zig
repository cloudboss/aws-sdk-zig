const std = @import("std");

pub const TargetStatus = enum {
    /// The target is deregistering and connection draining is in process.
    draining,
    /// Health checks are disabled.
    unavailable,
    /// The target is healthy.
    healthy,
    /// The target failed the health check.
    unhealthy,
    /// The initial health check is in progress.
    initial,
    /// The target group is not used in a listener rule.
    unused,

    pub const json_field_names = .{
        .draining = "DRAINING",
        .unavailable = "UNAVAILABLE",
        .healthy = "HEALTHY",
        .unhealthy = "UNHEALTHY",
        .initial = "INITIAL",
        .unused = "UNUSED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .draining => "DRAINING",
            .unavailable => "UNAVAILABLE",
            .healthy => "HEALTHY",
            .unhealthy => "UNHEALTHY",
            .initial => "INITIAL",
            .unused => "UNUSED",
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
