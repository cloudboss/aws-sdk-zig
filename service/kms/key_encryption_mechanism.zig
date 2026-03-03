const std = @import("std");

pub const KeyEncryptionMechanism = enum {
    rsaes_oaep_sha_256,

    pub const json_field_names = .{
        .rsaes_oaep_sha_256 = "RSAES_OAEP_SHA_256",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .rsaes_oaep_sha_256 => "RSAES_OAEP_SHA_256",
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
