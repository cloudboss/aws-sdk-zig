const std = @import("std");

pub const MigrationErrorType = enum {
    entity_not_supported,
    entity_not_found,
    s3_bucket_no_permission,
    s3_bucket_not_accessible,
    s3_bucket_not_found,
    s3_bucket_invalid_region,
    s3_internal_error,

    pub const json_field_names = .{
        .entity_not_supported = "ENTITY_NOT_SUPPORTED",
        .entity_not_found = "ENTITY_NOT_FOUND",
        .s3_bucket_no_permission = "S3_BUCKET_NO_PERMISSION",
        .s3_bucket_not_accessible = "S3_BUCKET_NOT_ACCESSIBLE",
        .s3_bucket_not_found = "S3_BUCKET_NOT_FOUND",
        .s3_bucket_invalid_region = "S3_BUCKET_INVALID_REGION",
        .s3_internal_error = "S3_INTERNAL_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .entity_not_supported => "ENTITY_NOT_SUPPORTED",
            .entity_not_found => "ENTITY_NOT_FOUND",
            .s3_bucket_no_permission => "S3_BUCKET_NO_PERMISSION",
            .s3_bucket_not_accessible => "S3_BUCKET_NOT_ACCESSIBLE",
            .s3_bucket_not_found => "S3_BUCKET_NOT_FOUND",
            .s3_bucket_invalid_region => "S3_BUCKET_INVALID_REGION",
            .s3_internal_error => "S3_INTERNAL_ERROR",
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
