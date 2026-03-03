const std = @import("std");

pub const Format = enum {
    mp_4,
    quicktime,
    matroska,
    webm,
    mxf,
    wave,

    pub const json_field_names = .{
        .mp_4 = "mp4",
        .quicktime = "quicktime",
        .matroska = "matroska",
        .webm = "webm",
        .mxf = "mxf",
        .wave = "wave",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .mp_4 => "mp4",
            .quicktime => "quicktime",
            .matroska => "matroska",
            .webm => "webm",
            .mxf => "mxf",
            .wave => "wave",
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
