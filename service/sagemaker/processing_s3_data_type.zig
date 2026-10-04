const std = @import("std");

pub const ProcessingS3DataType = enum {
    manifest_file,
    s3_prefix,

    pub const json_field_names = .{
        .manifest_file = "ManifestFile",
        .s3_prefix = "S3Prefix",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .manifest_file => "ManifestFile",
            .s3_prefix => "S3Prefix",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
