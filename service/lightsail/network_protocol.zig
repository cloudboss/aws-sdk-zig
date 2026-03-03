const std = @import("std");

pub const NetworkProtocol = enum {
    tcp,
    all,
    udp,
    icmp,
    icmpv6,

    pub const json_field_names = .{
        .tcp = "tcp",
        .all = "all",
        .udp = "udp",
        .icmp = "icmp",
        .icmpv6 = "icmpv6",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .tcp => "tcp",
            .all => "all",
            .udp => "udp",
            .icmp => "icmp",
            .icmpv6 => "icmpv6",
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
