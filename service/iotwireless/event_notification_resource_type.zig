const std = @import("std");

pub const EventNotificationResourceType = enum {
    sidewalk_account,
    wireless_device,
    wireless_gateway,

    pub const json_field_names = .{
        .sidewalk_account = "SidewalkAccount",
        .wireless_device = "WirelessDevice",
        .wireless_gateway = "WirelessGateway",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sidewalk_account => "SidewalkAccount",
            .wireless_device => "WirelessDevice",
            .wireless_gateway => "WirelessGateway",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
