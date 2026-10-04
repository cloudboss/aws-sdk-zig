const std = @import("std");

/// The IP address types that can invoke your API or domain name.
pub const IpAddressType = enum {
    ipv_4,
    dualstack,

    pub const json_field_names = .{
        .ipv_4 = "ipv4",
        .dualstack = "dualstack",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ipv_4 => "ipv4",
            .dualstack => "dualstack",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
