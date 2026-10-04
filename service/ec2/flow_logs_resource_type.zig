const std = @import("std");

pub const FlowLogsResourceType = enum {
    vpc,
    subnet,
    network_interface,
    transit_gateway,
    transit_gateway_attachment,
    regional_nat_gateway,

    pub const json_field_names = .{
        .vpc = "VPC",
        .subnet = "Subnet",
        .network_interface = "NetworkInterface",
        .transit_gateway = "TransitGateway",
        .transit_gateway_attachment = "TransitGatewayAttachment",
        .regional_nat_gateway = "RegionalNatGateway",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .vpc => "VPC",
            .subnet => "Subnet",
            .network_interface => "NetworkInterface",
            .transit_gateway => "TransitGateway",
            .transit_gateway_attachment => "TransitGatewayAttachment",
            .regional_nat_gateway => "RegionalNatGateway",
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
