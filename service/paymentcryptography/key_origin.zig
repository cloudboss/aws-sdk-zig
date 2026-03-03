const std = @import("std");

/// Defines the source of a key
pub const KeyOrigin = enum {
    external,
    aws_payment_cryptography,

    pub const json_field_names = .{
        .external = "EXTERNAL",
        .aws_payment_cryptography = "AWS_PAYMENT_CRYPTOGRAPHY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .external => "EXTERNAL",
            .aws_payment_cryptography => "AWS_PAYMENT_CRYPTOGRAPHY",
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
