const std = @import("std");

pub const IPAddressType = enum {
    /// Indicates that connections to this workspace can only be made over IPv4.
    ipv4,
    /// Indicates that connections to this workspace can be made over IPv4 or IPv6.
    dual_stack,

    pub const json_field_names = .{
        .ipv4 = "IPv4",
        .dual_stack = "DualStack",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ipv4 => "IPv4",
            .dual_stack => "DualStack",
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
