const std = @import("std");

pub const ValidationExceptionReason = enum {
    kms_invalid_key_usage_exception,
    kms_invalid_state_exception,
    kms_disabled_exception,

    pub const json_field_names = .{
        .kms_invalid_key_usage_exception = "KMS_InvalidKeyUsageException",
        .kms_invalid_state_exception = "KMS_InvalidStateException",
        .kms_disabled_exception = "KMS_DisabledException",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .kms_invalid_key_usage_exception => "KMS_InvalidKeyUsageException",
            .kms_invalid_state_exception => "KMS_InvalidStateException",
            .kms_disabled_exception => "KMS_DisabledException",
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
