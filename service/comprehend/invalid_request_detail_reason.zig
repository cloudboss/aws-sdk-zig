const std = @import("std");

pub const InvalidRequestDetailReason = enum {
    document_size_exceeded,
    unsupported_doc_type,
    page_limit_exceeded,
    textract_access_denied,

    pub const json_field_names = .{
        .document_size_exceeded = "DOCUMENT_SIZE_EXCEEDED",
        .unsupported_doc_type = "UNSUPPORTED_DOC_TYPE",
        .page_limit_exceeded = "PAGE_LIMIT_EXCEEDED",
        .textract_access_denied = "TEXTRACT_ACCESS_DENIED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .document_size_exceeded => "DOCUMENT_SIZE_EXCEEDED",
            .unsupported_doc_type => "UNSUPPORTED_DOC_TYPE",
            .page_limit_exceeded => "PAGE_LIMIT_EXCEEDED",
            .textract_access_denied => "TEXTRACT_ACCESS_DENIED",
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
