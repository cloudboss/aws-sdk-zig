const std = @import("std");

pub const PublicIpDnsOption = enum {
    public_dual_stack_dns_name,
    public_ipv_4_dns_name,
    public_ipv_6_dns_name,

    pub const json_field_names = .{
        .public_dual_stack_dns_name = "public-dual-stack-dns-name",
        .public_ipv_4_dns_name = "public-ipv4-dns-name",
        .public_ipv_6_dns_name = "public-ipv6-dns-name",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .public_dual_stack_dns_name => "public-dual-stack-dns-name",
            .public_ipv_4_dns_name => "public-ipv4-dns-name",
            .public_ipv_6_dns_name => "public-ipv6-dns-name",
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
