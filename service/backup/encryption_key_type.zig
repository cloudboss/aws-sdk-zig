const std = @import("std");

pub const EncryptionKeyType = enum {
    aws_owned_kms_key,
    customer_managed_kms_key,

    pub const json_field_names = .{
        .aws_owned_kms_key = "AWS_OWNED_KMS_KEY",
        .customer_managed_kms_key = "CUSTOMER_MANAGED_KMS_KEY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_owned_kms_key => "AWS_OWNED_KMS_KEY",
            .customer_managed_kms_key => "CUSTOMER_MANAGED_KMS_KEY",
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
