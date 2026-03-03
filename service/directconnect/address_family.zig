const std = @import("std");

pub const AddressFamily = enum {
    i_pv_4,
    i_pv_6,

    pub const json_field_names = .{
        .i_pv_4 = "ipv4",
        .i_pv_6 = "ipv6",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .i_pv_4 => "ipv4",
            .i_pv_6 => "ipv6",
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
