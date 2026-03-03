const std = @import("std");

pub const S3StorageClass = enum {
    standard,
    standard_ia,
    onezone_ia,
    intelligent_tiering,
    glacier,
    deep_archive,
    outposts,
    glacier_instant_retrieval,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .standard_ia = "STANDARD_IA",
        .onezone_ia = "ONEZONE_IA",
        .intelligent_tiering = "INTELLIGENT_TIERING",
        .glacier = "GLACIER",
        .deep_archive = "DEEP_ARCHIVE",
        .outposts = "OUTPOSTS",
        .glacier_instant_retrieval = "GLACIER_INSTANT_RETRIEVAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .standard => "STANDARD",
            .standard_ia => "STANDARD_IA",
            .onezone_ia => "ONEZONE_IA",
            .intelligent_tiering => "INTELLIGENT_TIERING",
            .glacier => "GLACIER",
            .deep_archive => "DEEP_ARCHIVE",
            .outposts => "OUTPOSTS",
            .glacier_instant_retrieval => "GLACIER_INSTANT_RETRIEVAL",
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
