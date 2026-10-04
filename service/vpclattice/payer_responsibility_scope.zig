const std = @import("std");

pub const PayerResponsibilityScope = enum {
    /// Charges for the resource gateway
    resource_gateway_charges,

    pub const json_field_names = .{
        .resource_gateway_charges = "ResourceGatewayCharges",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .resource_gateway_charges => "ResourceGatewayCharges",
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
