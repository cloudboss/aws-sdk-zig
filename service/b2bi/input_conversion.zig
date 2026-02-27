const AdvancedOptions = @import("advanced_options.zig").AdvancedOptions;
const FormatOptions = @import("format_options.zig").FormatOptions;
const FromFormat = @import("from_format.zig").FromFormat;

/// Contains the input formatting options for an inbound transformer (takes an
/// X12-formatted EDI document as input and converts it to JSON or XML.
pub const InputConversion = struct {
    /// Specifies advanced options for the input conversion process. These options
    /// provide additional control over how EDI files are processed during
    /// transformation.
    advanced_options: ?AdvancedOptions,

    /// A structure that contains the formatting options for an inbound transformer.
    format_options: ?FormatOptions,

    /// The format for the transformer input: currently on `X12` is supported.
    from_format: FromFormat,

    pub const json_field_names = .{
        .advanced_options = "advancedOptions",
        .format_options = "formatOptions",
        .from_format = "fromFormat",
    };
};
