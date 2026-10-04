const std = @import("std");

pub const IPAddressType = enum {
    ip_v4,

    pub const json_field_names = .{
        .ip_v4 = "IP_V4",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ip_v4 => "IP_V4",
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
