const std = @import("std");

pub const ActionType = enum {
    instance_refresh,
    platform_update,
    unknown,

    pub const json_field_names = .{
        .instance_refresh = "InstanceRefresh",
        .platform_update = "PlatformUpdate",
        .unknown = "Unknown",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .instance_refresh => "InstanceRefresh",
            .platform_update => "PlatformUpdate",
            .unknown => "Unknown",
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
