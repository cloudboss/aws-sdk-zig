const std = @import("std");

pub const VpcEndpointType = enum {
    interface,
    gateway,
    gateway_load_balancer,
    resource,
    service_network,

    pub const json_field_names = .{
        .interface = "Interface",
        .gateway = "Gateway",
        .gateway_load_balancer = "GatewayLoadBalancer",
        .resource = "Resource",
        .service_network = "ServiceNetwork",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .interface => "Interface",
            .gateway => "Gateway",
            .gateway_load_balancer => "GatewayLoadBalancer",
            .resource => "Resource",
            .service_network => "ServiceNetwork",
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
