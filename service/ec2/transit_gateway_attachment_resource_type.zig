const std = @import("std");

pub const TransitGatewayAttachmentResourceType = enum {
    vpc,
    vpn,
    vpn_concentrator,
    direct_connect_gateway,
    connect,
    peering,
    tgw_peering,
    network_function,

    pub const json_field_names = .{
        .vpc = "vpc",
        .vpn = "vpn",
        .vpn_concentrator = "vpn-concentrator",
        .direct_connect_gateway = "direct-connect-gateway",
        .connect = "connect",
        .peering = "peering",
        .tgw_peering = "tgw-peering",
        .network_function = "network-function",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .vpc => "vpc",
            .vpn => "vpn",
            .vpn_concentrator => "vpn-concentrator",
            .direct_connect_gateway => "direct-connect-gateway",
            .connect => "connect",
            .peering => "peering",
            .tgw_peering => "tgw-peering",
            .network_function => "network-function",
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
