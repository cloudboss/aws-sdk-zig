const std = @import("std");

pub const FileType = enum {
    doc,
    docx,
    xlsx,
    pptx,
    pdf,
    png,
    jpg,
    svg,
    csv,

    pub const json_field_names = .{
        .doc = "application/msword",
        .docx = "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
        .xlsx = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
        .pptx = "application/vnd.openxmlformats-officedocument.presentationml.presentation",
        .pdf = "application/pdf",
        .png = "image/png",
        .jpg = "image/jpeg",
        .svg = "image/svg+xml",
        .csv = "text/csv",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .doc => "application/msword",
            .docx => "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
            .xlsx => "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
            .pptx => "application/vnd.openxmlformats-officedocument.presentationml.presentation",
            .pdf => "application/pdf",
            .png => "image/png",
            .jpg => "image/jpeg",
            .svg => "image/svg+xml",
            .csv => "text/csv",
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
