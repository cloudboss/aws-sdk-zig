const std = @import("std");

pub const AutoMLS3DataType = enum {
    manifest_file,
    s3_prefix,
    augmented_manifest_file,

    pub const json_field_names = .{
        .manifest_file = "ManifestFile",
        .s3_prefix = "S3Prefix",
        .augmented_manifest_file = "AugmentedManifestFile",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .manifest_file => "ManifestFile",
            .s3_prefix => "S3Prefix",
            .augmented_manifest_file => "AugmentedManifestFile",
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
