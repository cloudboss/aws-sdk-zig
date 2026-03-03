const std = @import("std");

pub const VerifiedAccessEndpointType = enum {
    load_balancer,
    network_interface,
    rds,
    cidr,

    pub const json_field_names = .{
        .load_balancer = "load-balancer",
        .network_interface = "network-interface",
        .rds = "rds",
        .cidr = "cidr",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .load_balancer => "load-balancer",
            .network_interface => "network-interface",
            .rds => "rds",
            .cidr => "cidr",
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
