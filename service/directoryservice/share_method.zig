const std = @import("std");

pub const ShareMethod = enum {
    organizations,
    handshake,

    pub const json_field_names = .{
        .organizations = "ORGANIZATIONS",
        .handshake = "HANDSHAKE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .organizations => "ORGANIZATIONS",
            .handshake => "HANDSHAKE",
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
