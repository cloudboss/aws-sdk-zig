const std = @import("std");

pub const DiscoveryType = enum {
    zwave,
    zigbee,
    cloud,
    custom,
    controller_capability_rediscovery,

    pub const json_field_names = .{
        .zwave = "ZWAVE",
        .zigbee = "ZIGBEE",
        .cloud = "CLOUD",
        .custom = "CUSTOM",
        .controller_capability_rediscovery = "CONTROLLER_CAPABILITY_REDISCOVERY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .zwave => "ZWAVE",
            .zigbee => "ZIGBEE",
            .cloud => "CLOUD",
            .custom => "CUSTOM",
            .controller_capability_rediscovery => "CONTROLLER_CAPABILITY_REDISCOVERY",
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
