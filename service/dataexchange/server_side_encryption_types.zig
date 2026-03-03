const std = @import("std");

pub const ServerSideEncryptionTypes = enum {
    aws_kms,
    aes256,

    pub const json_field_names = .{
        .aws_kms = "aws:kms",
        .aes256 = "AES256",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_kms => "aws:kms",
            .aes256 => "AES256",
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
