const std = @import("std");

pub const NetworkType = enum {
    dual_stack,
    ipv4_only,
    ipv6_only,

    pub const json_field_names = .{
        .dual_stack = "Dual-stack",
        .ipv4_only = "IPv4",
        .ipv6_only = "IPv6",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .dual_stack => "Dual-stack",
            .ipv4_only => "IPv4",
            .ipv6_only => "IPv6",
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
