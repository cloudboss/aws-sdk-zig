const std = @import("std");

pub const ExceptionCause = enum {
    insufficient_s3_bucket_policy,
    s3_access_denied,

    pub const json_field_names = .{
        .insufficient_s3_bucket_policy = "InsufficientS3BucketPolicy",
        .s3_access_denied = "S3AccessDenied",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .insufficient_s3_bucket_policy => "InsufficientS3BucketPolicy",
            .s3_access_denied => "S3AccessDenied",
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
