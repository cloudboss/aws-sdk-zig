const std = @import("std");

pub const ServiceQuotaExceededExceptionReason = enum {
    service_quota_exceeded_exception,
    kms_key_limit_exceeded,
    dependency_limit_exceeded,

    pub const json_field_names = .{
        .service_quota_exceeded_exception = "SERVICE_QUOTA_EXCEEDED_EXCEPTION",
        .kms_key_limit_exceeded = "KMS_KEY_LIMIT_EXCEEDED",
        .dependency_limit_exceeded = "DEPENDENCY_LIMIT_EXCEEDED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .service_quota_exceeded_exception => "SERVICE_QUOTA_EXCEEDED_EXCEPTION",
            .kms_key_limit_exceeded => "KMS_KEY_LIMIT_EXCEEDED",
            .dependency_limit_exceeded => "DEPENDENCY_LIMIT_EXCEEDED",
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
