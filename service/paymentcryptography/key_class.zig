const std = @import("std");

pub const KeyClass = enum {
    symmetric_key,
    asymmetric_key_pair,
    private_key,
    public_key,

    pub const json_field_names = .{
        .symmetric_key = "SYMMETRIC_KEY",
        .asymmetric_key_pair = "ASYMMETRIC_KEY_PAIR",
        .private_key = "PRIVATE_KEY",
        .public_key = "PUBLIC_KEY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .symmetric_key => "SYMMETRIC_KEY",
            .asymmetric_key_pair => "ASYMMETRIC_KEY_PAIR",
            .private_key => "PRIVATE_KEY",
            .public_key => "PUBLIC_KEY",
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
