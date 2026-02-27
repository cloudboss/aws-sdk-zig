const DocumentStandardExtraction = @import("document_standard_extraction.zig").DocumentStandardExtraction;
const DocumentStandardGenerativeField = @import("document_standard_generative_field.zig").DocumentStandardGenerativeField;
const DocumentOutputFormat = @import("document_output_format.zig").DocumentOutputFormat;

/// Standard Output Configuration of Document
pub const DocumentStandardOutputConfiguration = struct {
    extraction: ?DocumentStandardExtraction,

    generative_field: ?DocumentStandardGenerativeField,

    output_format: ?DocumentOutputFormat,

    pub const json_field_names = .{
        .extraction = "extraction",
        .generative_field = "generativeField",
        .output_format = "outputFormat",
    };
};
