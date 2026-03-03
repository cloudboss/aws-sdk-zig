const std = @import("std");

pub const MediaAnalysisJobFailureCode = enum {
    internal_error,
    invalid_s3_object,
    invalid_manifest,
    invalid_output_config,
    invalid_kms_key,
    access_denied,
    resource_not_found,
    resource_not_ready,
    throttled,

    pub const json_field_names = .{
        .internal_error = "INTERNAL_ERROR",
        .invalid_s3_object = "INVALID_S3_OBJECT",
        .invalid_manifest = "INVALID_MANIFEST",
        .invalid_output_config = "INVALID_OUTPUT_CONFIG",
        .invalid_kms_key = "INVALID_KMS_KEY",
        .access_denied = "ACCESS_DENIED",
        .resource_not_found = "RESOURCE_NOT_FOUND",
        .resource_not_ready = "RESOURCE_NOT_READY",
        .throttled = "THROTTLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .internal_error => "INTERNAL_ERROR",
            .invalid_s3_object => "INVALID_S3_OBJECT",
            .invalid_manifest => "INVALID_MANIFEST",
            .invalid_output_config => "INVALID_OUTPUT_CONFIG",
            .invalid_kms_key => "INVALID_KMS_KEY",
            .access_denied => "ACCESS_DENIED",
            .resource_not_found => "RESOURCE_NOT_FOUND",
            .resource_not_ready => "RESOURCE_NOT_READY",
            .throttled => "THROTTLED",
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
