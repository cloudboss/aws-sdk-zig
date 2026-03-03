const std = @import("std");

/// Specifies whether the input device has been configured (outside of
/// MediaLive) to use a dynamic IP address assignment (DHCP) or a static IP
/// address.
pub const InputDeviceIpScheme = enum {
    static,
    dhcp,

    pub const json_field_names = .{
        .static = "STATIC",
        .dhcp = "DHCP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .static => "STATIC",
            .dhcp => "DHCP",
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
