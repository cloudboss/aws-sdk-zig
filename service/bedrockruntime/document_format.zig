const std = @import("std");

pub const DocumentFormat = enum {
    pdf,
    csv,
    doc,
    docx,
    xls,
    xlsx,
    html,
    txt,
    md,

    pub const json_field_names = .{
        .pdf = "pdf",
        .csv = "csv",
        .doc = "doc",
        .docx = "docx",
        .xls = "xls",
        .xlsx = "xlsx",
        .html = "html",
        .txt = "txt",
        .md = "md",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pdf => "pdf",
            .csv => "csv",
            .doc => "doc",
            .docx => "docx",
            .xls => "xls",
            .xlsx => "xlsx",
            .html => "html",
            .txt => "txt",
            .md => "md",
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
