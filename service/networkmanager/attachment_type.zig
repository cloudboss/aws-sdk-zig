const std = @import("std");

pub const AttachmentType = enum {
    connect,
    site_to_site_vpn,
    vpc,
    direct_connect_gateway,
    transit_gateway_route_table,

    pub const json_field_names = .{
        .connect = "CONNECT",
        .site_to_site_vpn = "SITE_TO_SITE_VPN",
        .vpc = "VPC",
        .direct_connect_gateway = "DIRECT_CONNECT_GATEWAY",
        .transit_gateway_route_table = "TRANSIT_GATEWAY_ROUTE_TABLE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .connect => "CONNECT",
            .site_to_site_vpn => "SITE_TO_SITE_VPN",
            .vpc => "VPC",
            .direct_connect_gateway => "DIRECT_CONNECT_GATEWAY",
            .transit_gateway_route_table => "TRANSIT_GATEWAY_ROUTE_TABLE",
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
