const std = @import("std");

pub const NetworkType = enum {
    ipv4,
    ipv6,
    dual_stack,

    pub const json_field_names = .{
        .ipv4 = "ipv4",
        .ipv6 = "ipv6",
        .dual_stack = "dual_stack",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ipv4 => "ipv4",
            .ipv6 => "ipv6",
            .dual_stack => "dual_stack",
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
