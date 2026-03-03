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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
