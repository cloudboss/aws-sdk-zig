const std = @import("std");

pub const ServiceType = enum {
    interface,
    gateway,
    gateway_load_balancer,

    pub const json_field_names = .{
        .interface = "Interface",
        .gateway = "Gateway",
        .gateway_load_balancer = "GatewayLoadBalancer",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .interface => "Interface",
            .gateway => "Gateway",
            .gateway_load_balancer => "GatewayLoadBalancer",
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
