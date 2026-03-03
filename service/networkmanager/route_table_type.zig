const std = @import("std");

pub const RouteTableType = enum {
    transit_gateway_route_table,
    core_network_segment,
    network_function_group,

    pub const json_field_names = .{
        .transit_gateway_route_table = "TRANSIT_GATEWAY_ROUTE_TABLE",
        .core_network_segment = "CORE_NETWORK_SEGMENT",
        .network_function_group = "NETWORK_FUNCTION_GROUP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .transit_gateway_route_table => "TRANSIT_GATEWAY_ROUTE_TABLE",
            .core_network_segment => "CORE_NETWORK_SEGMENT",
            .network_function_group => "NETWORK_FUNCTION_GROUP",
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
