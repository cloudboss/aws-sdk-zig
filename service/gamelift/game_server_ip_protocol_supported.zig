const std = @import("std");

pub const GameServerIpProtocolSupported = enum {
    i_pv_4,
    dual_stack,

    pub const json_field_names = .{
        .i_pv_4 = "IPv4",
        .dual_stack = "DUAL_STACK",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .i_pv_4 => "IPv4",
            .dual_stack => "DUAL_STACK",
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
