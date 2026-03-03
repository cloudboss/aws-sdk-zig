const std = @import("std");

pub const EncryptionType = enum {
    aws_owned_key,
    customer_managed_kms_key,

    pub const json_field_names = .{
        .aws_owned_key = "AWS_OWNED_KEY",
        .customer_managed_kms_key = "CUSTOMER_MANAGED_KMS_KEY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_owned_key => "AWS_OWNED_KEY",
            .customer_managed_kms_key => "CUSTOMER_MANAGED_KMS_KEY",
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
