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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
