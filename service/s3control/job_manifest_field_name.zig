const std = @import("std");

pub const JobManifestFieldName = enum {
    ignore,
    bucket,
    key,
    version_id,

    pub const json_field_names = .{
        .ignore = "Ignore",
        .bucket = "Bucket",
        .key = "Key",
        .version_id = "VersionId",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ignore => "Ignore",
            .bucket => "Bucket",
            .key => "Key",
            .version_id => "VersionId",
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
