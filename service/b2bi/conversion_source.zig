const ConversionSourceFormat = @import("conversion_source_format.zig").ConversionSourceFormat;
const InputFileSource = @import("input_file_source.zig").InputFileSource;

/// Describes the input for an outbound transformation.
pub const ConversionSource = struct {
    /// The format for the input file: either JSON or XML.
    file_format: ConversionSourceFormat,

    /// File to be converted
    input_file: InputFileSource,

    pub const json_field_names = .{
        .file_format = "fileFormat",
        .input_file = "inputFile",
    };
};
