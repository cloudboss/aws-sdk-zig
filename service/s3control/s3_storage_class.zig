const std = @import("std");

pub const S3StorageClass = enum {
    standard,
    standard_ia,
    onezone_ia,
    glacier,
    intelligent_tiering,
    deep_archive,
    glacier_ir,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .standard_ia = "STANDARD_IA",
        .onezone_ia = "ONEZONE_IA",
        .glacier = "GLACIER",
        .intelligent_tiering = "INTELLIGENT_TIERING",
        .deep_archive = "DEEP_ARCHIVE",
        .glacier_ir = "GLACIER_IR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .standard => "STANDARD",
            .standard_ia => "STANDARD_IA",
            .onezone_ia => "ONEZONE_IA",
            .glacier => "GLACIER",
            .intelligent_tiering => "INTELLIGENT_TIERING",
            .deep_archive => "DEEP_ARCHIVE",
            .glacier_ir => "GLACIER_IR",
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
