const std = @import("std");

pub const IdentifierType = enum {
    partner_account_id,
    dev_eui,
    gateway_eui,
    wireless_device_id,
    wireless_gateway_id,

    pub const json_field_names = .{
        .partner_account_id = "PartnerAccountId",
        .dev_eui = "DevEui",
        .gateway_eui = "GatewayEui",
        .wireless_device_id = "WirelessDeviceId",
        .wireless_gateway_id = "WirelessGatewayId",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .partner_account_id => "PartnerAccountId",
            .dev_eui => "DevEui",
            .gateway_eui => "GatewayEui",
            .wireless_device_id => "WirelessDeviceId",
            .wireless_gateway_id => "WirelessGatewayId",
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
