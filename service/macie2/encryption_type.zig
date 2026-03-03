const std = @import("std");

/// The server-side encryption algorithm that was used to encrypt an S3 object
/// or is used by default to encrypt objects that are added to an S3 bucket.
/// Possible values are:
pub const EncryptionType = enum {
    none,
    aes256,
    aws_kms,
    unknown,
    aws_kms_dsse,

    pub const json_field_names = .{
        .none = "NONE",
        .aes256 = "AES256",
        .aws_kms = "aws:kms",
        .unknown = "UNKNOWN",
        .aws_kms_dsse = "aws:kms:dsse",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .aes256 => "AES256",
            .aws_kms => "aws:kms",
            .unknown => "UNKNOWN",
            .aws_kms_dsse => "aws:kms:dsse",
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
