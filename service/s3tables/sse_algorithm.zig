const std = @import("std");

pub const SSEAlgorithm = enum {
    aes256,
    aws_kms,

    pub const json_field_names = .{
        .aes256 = "AES256",
        .aws_kms = "aws:kms",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aes256 => "AES256",
            .aws_kms => "aws:kms",
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
