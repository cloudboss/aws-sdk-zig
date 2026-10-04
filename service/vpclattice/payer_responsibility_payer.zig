const std = @import("std");

pub const PayerResponsibilityPayer = enum {
    /// The VPC endpoint account pays
    vpc_endpoint_account,
    /// The resource gateway account pays
    resource_gateway_account,

    pub const json_field_names = .{
        .vpc_endpoint_account = "VpcEndpointAccount",
        .resource_gateway_account = "ResourceGatewayAccount",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .vpc_endpoint_account => "VpcEndpointAccount",
            .resource_gateway_account => "ResourceGatewayAccount",
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
