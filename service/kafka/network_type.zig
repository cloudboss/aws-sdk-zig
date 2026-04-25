const std = @import("std");

/// The network type of the cluster, which is IPv4 or DUAL. The DUAL network
/// type uses both IPv4 and IPv6 addresses for your cluster and its resources.
///
/// By default, a cluster uses the IPv4 network type.
pub const NetworkType = enum {
    ipv4,
    dual,

    pub const json_field_names = .{
        .ipv4 = "IPV4",
        .dual = "DUAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ipv4 => "IPV4",
            .dual => "DUAL",
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
