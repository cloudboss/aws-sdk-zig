const std = @import("std");

pub const TransitionStorageClass = enum {
    glacier,
    standard_ia,
    onezone_ia,
    intelligent_tiering,
    deep_archive,

    pub const json_field_names = .{
        .glacier = "GLACIER",
        .standard_ia = "STANDARD_IA",
        .onezone_ia = "ONEZONE_IA",
        .intelligent_tiering = "INTELLIGENT_TIERING",
        .deep_archive = "DEEP_ARCHIVE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .glacier => "GLACIER",
            .standard_ia => "STANDARD_IA",
            .onezone_ia => "ONEZONE_IA",
            .intelligent_tiering => "INTELLIGENT_TIERING",
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
