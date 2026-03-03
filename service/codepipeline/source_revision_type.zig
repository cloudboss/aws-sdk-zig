const std = @import("std");

pub const SourceRevisionType = enum {
    commit_id,
    image_digest,
    s3_object_version_id,
    s3_object_key,

    pub const json_field_names = .{
        .commit_id = "COMMIT_ID",
        .image_digest = "IMAGE_DIGEST",
        .s3_object_version_id = "S3_OBJECT_VERSION_ID",
        .s3_object_key = "S3_OBJECT_KEY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .commit_id => "COMMIT_ID",
            .image_digest => "IMAGE_DIGEST",
            .s3_object_version_id => "S3_OBJECT_VERSION_ID",
            .s3_object_key => "S3_OBJECT_KEY",
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
