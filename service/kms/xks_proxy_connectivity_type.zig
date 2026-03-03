const std = @import("std");

pub const XksProxyConnectivityType = enum {
    public_endpoint,
    vpc_endpoint_service,

    pub const json_field_names = .{
        .public_endpoint = "PUBLIC_ENDPOINT",
        .vpc_endpoint_service = "VPC_ENDPOINT_SERVICE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .public_endpoint => "PUBLIC_ENDPOINT",
            .vpc_endpoint_service => "VPC_ENDPOINT_SERVICE",
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
