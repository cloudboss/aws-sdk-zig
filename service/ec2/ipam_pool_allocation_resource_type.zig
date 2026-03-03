const std = @import("std");

pub const IpamPoolAllocationResourceType = enum {
    ipam_pool,
    vpc,
    ec_2_public_ipv_4_pool,
    custom,
    subnet,
    eip,
    anycast_ip_list,

    pub const json_field_names = .{
        .ipam_pool = "ipam-pool",
        .vpc = "vpc",
        .ec_2_public_ipv_4_pool = "ec2-public-ipv4-pool",
        .custom = "custom",
        .subnet = "subnet",
        .eip = "eip",
        .anycast_ip_list = "anycast-ip-list",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ipam_pool => "ipam-pool",
            .vpc => "vpc",
            .ec_2_public_ipv_4_pool => "ec2-public-ipv4-pool",
            .custom => "custom",
            .subnet => "subnet",
            .eip => "eip",
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
