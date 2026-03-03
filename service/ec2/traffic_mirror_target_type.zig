const std = @import("std");

pub const TrafficMirrorTargetType = enum {
    network_interface,
    network_load_balancer,
    gateway_load_balancer_endpoint,

    pub const json_field_names = .{
        .network_interface = "network-interface",
        .network_load_balancer = "network-load-balancer",
        .gateway_load_balancer_endpoint = "gateway-load-balancer-endpoint",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .network_interface => "network-interface",
            .network_load_balancer => "network-load-balancer",
            .gateway_load_balancer_endpoint => "gateway-load-balancer-endpoint",
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
