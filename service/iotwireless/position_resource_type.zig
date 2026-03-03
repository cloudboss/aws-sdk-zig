const std = @import("std");

pub const PositionResourceType = enum {
    wireless_device,
    wireless_gateway,

    pub const json_field_names = .{
        .wireless_device = "WirelessDevice",
        .wireless_gateway = "WirelessGateway",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .wireless_device => "WirelessDevice",
            .wireless_gateway => "WirelessGateway",
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
