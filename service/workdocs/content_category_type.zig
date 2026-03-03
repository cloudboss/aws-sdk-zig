const std = @import("std");

pub const ContentCategoryType = enum {
    image,
    document,
    pdf,
    spreadsheet,
    presentation,
    audio,
    video,
    source_code,
    other,

    pub const json_field_names = .{
        .image = "IMAGE",
        .document = "DOCUMENT",
        .pdf = "PDF",
        .spreadsheet = "SPREADSHEET",
        .presentation = "PRESENTATION",
        .audio = "AUDIO",
        .video = "VIDEO",
        .source_code = "SOURCE_CODE",
        .other = "OTHER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .image => "IMAGE",
            .document => "DOCUMENT",
            .pdf => "PDF",
            .spreadsheet => "SPREADSHEET",
            .presentation => "PRESENTATION",
            .audio => "AUDIO",
            .video => "VIDEO",
            .source_code => "SOURCE_CODE",
            .other => "OTHER",
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
