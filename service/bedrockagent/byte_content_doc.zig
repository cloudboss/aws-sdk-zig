/// Contains information about content defined inline in bytes.
pub const ByteContentDoc = struct {
    /// The base64-encoded string of the content.
    data: []const u8,

    /// The MIME type of the content. For a list of MIME types, see [Media
    /// Types](https://www.iana.org/assignments/media-types/media-types.xhtml). The
    /// following MIME types are supported:
    ///
    /// * text/plain
    /// * text/html
    /// * text/csv
    /// * text/vtt
    /// * message/rfc822
    /// * application/xhtml+xml
    /// * application/pdf
    /// * application/msword
    /// * application/vnd.ms-word.document.macroenabled.12
    /// * application/vnd.ms-word.template.macroenabled.12
    /// * application/vnd.ms-excel
    /// * application/vnd.ms-excel.addin.macroenabled.12
    /// * application/vnd.ms-excel.sheet.macroenabled.12
    /// * application/vnd.ms-excel.template.macroenabled.12
    /// * application/vnd.ms-excel.sheet.binary.macroenabled.12
    /// * application/vnd.ms-spreadsheetml
    /// * application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
    /// * application/vnd.openxmlformats-officedocument.spreadsheetml.template
    /// * application/vnd.openxmlformats-officedocument.wordprocessingml.document
    /// * application/vnd.openxmlformats-officedocument.wordprocessingml.template
    mime_type: []const u8,

    pub const json_field_names = .{
        .data = "data",
        .mime_type = "mimeType",
    };
};
