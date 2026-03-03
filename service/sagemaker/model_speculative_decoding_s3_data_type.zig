const std = @import("std");

pub const ModelSpeculativeDecodingS3DataType = enum {
    s3_prefix,
    manifest_file,

    pub const json_field_names = .{
        .s3_prefix = "S3Prefix",
        .manifest_file = "ManifestFile",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .s3_prefix => "S3Prefix",
            .manifest_file => "ManifestFile",
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
