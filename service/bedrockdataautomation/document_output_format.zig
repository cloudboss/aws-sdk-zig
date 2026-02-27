const DocumentOutputAdditionalFileFormat = @import("document_output_additional_file_format.zig").DocumentOutputAdditionalFileFormat;
const DocumentOutputTextFormat = @import("document_output_text_format.zig").DocumentOutputTextFormat;

/// Output Format of Document
pub const DocumentOutputFormat = struct {
    additional_file_format: DocumentOutputAdditionalFileFormat,

    text_format: DocumentOutputTextFormat,

    pub const json_field_names = .{
        .additional_file_format = "additionalFileFormat",
        .text_format = "textFormat",
    };
};
