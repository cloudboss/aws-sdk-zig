const std = @import("std");

pub const InvalidRequestExceptionReason = enum {
    kms_key_not_found,
    kms_invalid_key_usage,
    kms_invalid_state,
    kms_disabled_key,

    pub const json_field_names = .{
        .kms_key_not_found = "KMS_NotFoundException",
        .kms_invalid_key_usage = "KMS_InvalidKeyUsageException",
        .kms_invalid_state = "KMS_InvalidStateException",
        .kms_disabled_key = "KMS_DisabledException",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .kms_key_not_found => "KMS_NotFoundException",
            .kms_invalid_key_usage => "KMS_InvalidKeyUsageException",
            .kms_invalid_state => "KMS_InvalidStateException",
            .kms_disabled_key => "KMS_DisabledException",
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
