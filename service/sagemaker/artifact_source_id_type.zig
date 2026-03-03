const std = @import("std");

pub const ArtifactSourceIdType = enum {
    md5_hash,
    s3_etag,
    s3_version,
    custom,

    pub const json_field_names = .{
        .md5_hash = "MD5Hash",
        .s3_etag = "S3ETag",
        .s3_version = "S3Version",
        .custom = "Custom",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .md5_hash => "MD5Hash",
            .s3_etag => "S3ETag",
            .s3_version => "S3Version",
            .custom => "Custom",
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
