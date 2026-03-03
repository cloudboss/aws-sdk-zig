const std = @import("std");

pub const DeviceStatus = enum {
    online,
    offline,
    retired,

    pub const json_field_names = .{
        .online = "ONLINE",
        .offline = "OFFLINE",
        .retired = "RETIRED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .online => "ONLINE",
            .offline => "OFFLINE",
            .retired => "RETIRED",
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
