const std = @import("std");

pub const ArtifactsType = enum {
    codepipeline,
    s3,
    no_artifacts,

    pub const json_field_names = .{
        .codepipeline = "CODEPIPELINE",
        .s3 = "S3",
        .no_artifacts = "NO_ARTIFACTS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .codepipeline => "CODEPIPELINE",
            .s3 => "S3",
            .no_artifacts => "NO_ARTIFACTS",
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
