const std = @import("std");

pub const ContentType = enum {
    pdf,
    html,
    ms_word,
    plain_text,
    ppt,
    rtf,
    xml,
    xslt,
    ms_excel,
    csv,
    json,
    md,

    pub const json_field_names = .{
        .pdf = "PDF",
        .html = "HTML",
        .ms_word = "MS_WORD",
        .plain_text = "PLAIN_TEXT",
        .ppt = "PPT",
        .rtf = "RTF",
        .xml = "XML",
        .xslt = "XSLT",
        .ms_excel = "MS_EXCEL",
        .csv = "CSV",
        .json = "JSON",
        .md = "MD",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pdf => "PDF",
            .html => "HTML",
            .ms_word => "MS_WORD",
            .plain_text => "PLAIN_TEXT",
            .ppt => "PPT",
            .rtf => "RTF",
            .xml => "XML",
            .xslt => "XSLT",
            .ms_excel => "MS_EXCEL",
            .csv => "CSV",
            .json => "JSON",
            .md => "MD",
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
