const std = @import("std");

pub const InstanceHealthStatus = enum {
    healthy_status,
    unhealthy_status,

    pub const json_field_names = .{
        .healthy_status = "healthy",
        .unhealthy_status = "unhealthy",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .healthy_status => "healthy",
            .unhealthy_status => "unhealthy",
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
