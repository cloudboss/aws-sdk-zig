const std = @import("std");

pub const ProtocolType = enum {
    /// Resource Configuration protocol type TCP
    tcp,
    /// Resource Configuration protocol type TCP_UDP
    tcp_udp,

    pub const json_field_names = .{
        .tcp = "TCP",
        .tcp_udp = "TCP_UDP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .tcp => "TCP",
            .tcp_udp => "TCP_UDP",
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
