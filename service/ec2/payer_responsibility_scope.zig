const std = @import("std");

pub const PayerResponsibilityScope = enum {
    vpc_endpoint_charges,
    resource_gateway_charges,

    pub const json_field_names = .{
        .vpc_endpoint_charges = "vpc-endpoint-charges",
        .resource_gateway_charges = "resource-gateway-charges",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .vpc_endpoint_charges => "vpc-endpoint-charges",
            .resource_gateway_charges => "resource-gateway-charges",
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
