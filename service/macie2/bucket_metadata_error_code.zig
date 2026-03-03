const std = @import("std");

/// The code for an error or issue that prevented Amazon Macie from retrieving
/// and processing information about an S3 bucket and the bucket's objects.
pub const BucketMetadataErrorCode = enum {
    access_denied,
    bucket_count_exceeds_quota,

    pub const json_field_names = .{
        .access_denied = "ACCESS_DENIED",
        .bucket_count_exceeds_quota = "BUCKET_COUNT_EXCEEDS_QUOTA",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .access_denied => "ACCESS_DENIED",
            .bucket_count_exceeds_quota => "BUCKET_COUNT_EXCEEDS_QUOTA",
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
