const std = @import("std");

pub const KeyType = enum {
    rsa,
    ed_25519,

    pub const json_field_names = .{
        .rsa = "rsa",
        .ed_25519 = "ed25519",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .rsa => "rsa",
            .ed_25519 => "ed25519",
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
