const std = @import("std");

pub const DocumentType = enum {
    native_pdf,
    scanned_pdf,
    ms_word,
    image,
    plain_text,
    textract_detect_document_text_json,
    textract_analyze_document_json,

    pub const json_field_names = .{
        .native_pdf = "NATIVE_PDF",
        .scanned_pdf = "SCANNED_PDF",
        .ms_word = "MS_WORD",
        .image = "IMAGE",
        .plain_text = "PLAIN_TEXT",
        .textract_detect_document_text_json = "TEXTRACT_DETECT_DOCUMENT_TEXT_JSON",
        .textract_analyze_document_json = "TEXTRACT_ANALYZE_DOCUMENT_JSON",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .native_pdf => "NATIVE_PDF",
            .scanned_pdf => "SCANNED_PDF",
            .ms_word => "MS_WORD",
            .image => "IMAGE",
            .plain_text => "PLAIN_TEXT",
            .textract_detect_document_text_json => "TEXTRACT_DETECT_DOCUMENT_TEXT_JSON",
            .textract_analyze_document_json => "TEXTRACT_ANALYZE_DOCUMENT_JSON",
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
