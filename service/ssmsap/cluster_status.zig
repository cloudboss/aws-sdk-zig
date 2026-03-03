const std = @import("std");

pub const ClusterStatus = enum {
    online,
    standby,
    maintenance,
    offline,
    none,

    pub const json_field_names = .{
        .online = "ONLINE",
        .standby = "STANDBY",
        .maintenance = "MAINTENANCE",
        .offline = "OFFLINE",
        .none = "NONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .online => "ONLINE",
            .standby => "STANDBY",
            .maintenance => "MAINTENANCE",
            .offline => "OFFLINE",
            .none => "NONE",
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
