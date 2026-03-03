const std = @import("std");

pub const DocumentReadAction = enum {
    textract_detect_document_text,
    textract_analyze_document,

    pub const json_field_names = .{
        .textract_detect_document_text = "TEXTRACT_DETECT_DOCUMENT_TEXT",
        .textract_analyze_document = "TEXTRACT_ANALYZE_DOCUMENT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .textract_detect_document_text => "TEXTRACT_DETECT_DOCUMENT_TEXT",
            .textract_analyze_document => "TEXTRACT_ANALYZE_DOCUMENT",
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
