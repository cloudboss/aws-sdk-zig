const std = @import("std");

pub const IpamResourceType = enum {
    vpc,
    subnet,
    eip,
    public_ipv_4_pool,
    ipv_6_pool,
    eni,
    anycast_ip_list,

    pub const json_field_names = .{
        .vpc = "vpc",
        .subnet = "subnet",
        .eip = "eip",
        .public_ipv_4_pool = "public-ipv4-pool",
        .ipv_6_pool = "ipv6-pool",
        .eni = "eni",
        .anycast_ip_list = "anycast-ip-list",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .vpc => "vpc",
            .subnet => "subnet",
            .eip => "eip",
            .public_ipv_4_pool => "public-ipv4-pool",
            .ipv_6_pool => "ipv6-pool",
            .eni => "eni",
            .anycast_ip_list => "anycast-ip-list",
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
