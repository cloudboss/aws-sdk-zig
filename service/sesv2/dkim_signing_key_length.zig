const std = @import("std");

pub const DkimSigningKeyLength = enum {
    rsa_1024_bit,
    rsa_2048_bit,

    pub const json_field_names = .{
        .rsa_1024_bit = "RSA_1024_BIT",
        .rsa_2048_bit = "RSA_2048_BIT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .rsa_1024_bit => "RSA_1024_BIT",
            .rsa_2048_bit => "RSA_2048_BIT",
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
