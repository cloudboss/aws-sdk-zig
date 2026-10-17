const std = @import("std");

/// IP address type supported for VPC Origins. IPv6-only is not supported for
/// VPC Origins.
pub const VpcIpAddressType = enum {
    ipv_4,
    dual_stack,

    pub const json_field_names = .{
        .ipv_4 = "ipv4",
        .dual_stack = "dualstack",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ipv_4 => "ipv4",
            .dual_stack => "dualstack",
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
