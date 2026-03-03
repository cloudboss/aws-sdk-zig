const std = @import("std");

pub const VpcAttributeName = enum {
    enable_dns_support,
    enable_dns_hostnames,
    enable_network_address_usage_metrics,

    pub const json_field_names = .{
        .enable_dns_support = "enableDnsSupport",
        .enable_dns_hostnames = "enableDnsHostnames",
        .enable_network_address_usage_metrics = "enableNetworkAddressUsageMetrics",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enable_dns_support => "enableDnsSupport",
            .enable_dns_hostnames => "enableDnsHostnames",
            .enable_network_address_usage_metrics => "enableNetworkAddressUsageMetrics",
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
