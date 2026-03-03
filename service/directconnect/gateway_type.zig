const std = @import("std");

pub const GatewayType = enum {
    virtual_private_gateway,
    transit_gateway,

    pub const json_field_names = .{
        .virtual_private_gateway = "virtualPrivateGateway",
        .transit_gateway = "transitGateway",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .virtual_private_gateway => "virtualPrivateGateway",
            .transit_gateway => "transitGateway",
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
