const std = @import("std");

/// Specify the S3 storage class to use for this output. To use your
/// destination's default storage class: Keep the default value, Not set. For
/// more information about S3 storage classes, see
/// https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage-class-intro.html
pub const S3StorageClass = enum {
    standard,
    reduced_redundancy,
    standard_ia,
    onezone_ia,
    intelligent_tiering,
    glacier,
    deep_archive,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .reduced_redundancy = "REDUCED_REDUNDANCY",
        .standard_ia = "STANDARD_IA",
        .onezone_ia = "ONEZONE_IA",
        .intelligent_tiering = "INTELLIGENT_TIERING",
        .glacier = "GLACIER",
        .deep_archive = "DEEP_ARCHIVE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .standard => "STANDARD",
            .reduced_redundancy => "REDUCED_REDUNDANCY",
            .standard_ia => "STANDARD_IA",
            .onezone_ia => "ONEZONE_IA",
            .intelligent_tiering => "INTELLIGENT_TIERING",
            .glacier => "GLACIER",
            .deep_archive => "DEEP_ARCHIVE",
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
