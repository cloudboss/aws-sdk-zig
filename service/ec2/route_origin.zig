const std = @import("std");

pub const RouteOrigin = enum {
    create_route_table,
    create_route,
    enable_vgw_route_propagation,
    advertisement,

    pub const json_field_names = .{
        .create_route_table = "CreateRouteTable",
        .create_route = "CreateRoute",
        .enable_vgw_route_propagation = "EnableVgwRoutePropagation",
        .advertisement = "Advertisement",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .create_route_table => "CreateRouteTable",
            .create_route => "CreateRoute",
            .enable_vgw_route_propagation => "EnableVgwRoutePropagation",
            .advertisement => "Advertisement",
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
