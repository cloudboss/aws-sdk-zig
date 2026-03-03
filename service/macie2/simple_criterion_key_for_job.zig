const std = @import("std");

/// The property to use in a condition that determines whether an S3 bucket is
/// included or excluded from a classification job. Valid values are:
pub const SimpleCriterionKeyForJob = enum {
    account_id,
    s3_bucket_name,
    s3_bucket_effective_permission,
    s3_bucket_shared_access,

    pub const json_field_names = .{
        .account_id = "ACCOUNT_ID",
        .s3_bucket_name = "S3_BUCKET_NAME",
        .s3_bucket_effective_permission = "S3_BUCKET_EFFECTIVE_PERMISSION",
        .s3_bucket_shared_access = "S3_BUCKET_SHARED_ACCESS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .account_id => "ACCOUNT_ID",
            .s3_bucket_name => "S3_BUCKET_NAME",
            .s3_bucket_effective_permission => "S3_BUCKET_EFFECTIVE_PERMISSION",
            .s3_bucket_shared_access => "S3_BUCKET_SHARED_ACCESS",
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
