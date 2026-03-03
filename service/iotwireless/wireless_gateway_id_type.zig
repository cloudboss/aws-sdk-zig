const std = @import("std");

pub const WirelessGatewayIdType = enum {
    gateway_eui,
    wireless_gateway_id,
    thing_name,

    pub const json_field_names = .{
        .gateway_eui = "GatewayEui",
        .wireless_gateway_id = "WirelessGatewayId",
        .thing_name = "ThingName",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .gateway_eui => "GatewayEui",
            .wireless_gateway_id => "WirelessGatewayId",
            .thing_name => "ThingName",
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
