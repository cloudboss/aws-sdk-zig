const AdvancedOptions = @import("advanced_options.zig").AdvancedOptions;
const ConversionTargetFormat = @import("conversion_target_format.zig").ConversionTargetFormat;
const ConversionTargetFormatDetails = @import("conversion_target_format_details.zig").ConversionTargetFormatDetails;
const OutputSampleFileSource = @import("output_sample_file_source.zig").OutputSampleFileSource;

/// Provide a sample of what the output of the transformation should look like.
pub const ConversionTarget = struct {
    advanced_options: ?AdvancedOptions = null,

    /// Currently, only X12 format is supported.
    file_format: ConversionTargetFormat,

    /// A structure that contains the formatting details for the conversion target.
    format_details: ?ConversionTargetFormatDetails = null,

    /// Customer uses this to provide a sample on what should file look like after
    /// conversion
    /// X12 EDI use case around this would be discovering the file syntax
    output_sample_file: ?OutputSampleFileSource = null,

    pub const json_field_names = .{
        .advanced_options = "advancedOptions",
        .file_format = "fileFormat",
        .format_details = "formatDetails",
        .output_sample_file = "outputSampleFile",
    };
};
