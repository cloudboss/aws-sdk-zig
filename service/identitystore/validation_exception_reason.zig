const std = @import("std");

pub const ValidationExceptionReason = enum {
    kms_invalid_arn,
    kms_invalid_key_usage,
    kms_invalid_state,
    kms_disabled,

    pub const json_field_names = .{
        .kms_invalid_arn = "KMS_INVALID_ARN",
        .kms_invalid_key_usage = "KMS_INVALID_KEY_USAGE",
        .kms_invalid_state = "KMS_INVALID_STATE",
        .kms_disabled = "KMS_DISABLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .kms_invalid_arn => "KMS_INVALID_ARN",
            .kms_invalid_key_usage => "KMS_INVALID_KEY_USAGE",
            .kms_invalid_state => "KMS_INVALID_STATE",
            .kms_disabled => "KMS_DISABLED",
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
