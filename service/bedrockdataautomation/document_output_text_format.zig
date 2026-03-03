const DocumentOutputTextFormatType = @import("document_output_text_format_type.zig").DocumentOutputTextFormatType;

/// Text Format of Document Output
pub const DocumentOutputTextFormat = struct {
    types: ?[]const DocumentOutputTextFormatType = null,

    pub const json_field_names = .{
        .types = "types",
    };
};
