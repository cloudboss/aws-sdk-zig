const std = @import("std");

pub const PayerResponsibilityType = enum {
    vpc_endpoint_account,
    resource_gateway_account,
    vpc_endpoint_service_account,

    pub const json_field_names = .{
        .vpc_endpoint_account = "vpc-endpoint-account",
        .resource_gateway_account = "resource-gateway-account",
        .vpc_endpoint_service_account = "vpc-endpoint-service-account",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .vpc_endpoint_account => "vpc-endpoint-account",
            .resource_gateway_account => "resource-gateway-account",
            .vpc_endpoint_service_account => "vpc-endpoint-service-account",
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
