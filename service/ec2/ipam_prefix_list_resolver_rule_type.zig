const std = @import("std");

pub const IpamPrefixListResolverRuleType = enum {
    static_cidr,
    ipam_resource_cidr,
    ipam_pool_cidr,

    pub const json_field_names = .{
        .static_cidr = "static-cidr",
        .ipam_resource_cidr = "ipam-resource-cidr",
        .ipam_pool_cidr = "ipam-pool-cidr",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .static_cidr => "static-cidr",
            .ipam_resource_cidr => "ipam-resource-cidr",
            .ipam_pool_cidr => "ipam-pool-cidr",
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
