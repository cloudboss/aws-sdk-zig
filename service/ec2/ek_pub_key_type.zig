const std = @import("std");

pub const EkPubKeyType = enum {
    rsa_2048,
    ecc_sec_p384,

    pub const json_field_names = .{
        .rsa_2048 = "rsa-2048",
        .ecc_sec_p384 = "ecc-sec-p384",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .rsa_2048 => "rsa-2048",
            .ecc_sec_p384 => "ecc-sec-p384",
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
