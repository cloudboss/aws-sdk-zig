const std = @import("std");

/// Device state defines the device status of sidewalk device.
pub const DeviceState = enum {
    provisioned,
    registerednotseen,
    registeredreachable,
    registeredunreachable,

    pub const json_field_names = .{
        .provisioned = "Provisioned",
        .registerednotseen = "RegisteredNotSeen",
        .registeredreachable = "RegisteredReachable",
        .registeredunreachable = "RegisteredUnreachable",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .provisioned => "Provisioned",
            .registerednotseen => "RegisteredNotSeen",
            .registeredreachable => "RegisteredReachable",
            .registeredunreachable => "RegisteredUnreachable",
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
