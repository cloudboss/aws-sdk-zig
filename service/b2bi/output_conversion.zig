const AdvancedOptions = @import("advanced_options.zig").AdvancedOptions;
const FormatOptions = @import("format_options.zig").FormatOptions;
const ToFormat = @import("to_format.zig").ToFormat;

/// Contains the formatting options for an outbound transformer (takes JSON or
/// XML as input and converts it to an EDI document (currently only X12 format
/// is supported).
pub const OutputConversion = struct {
    advanced_options: ?AdvancedOptions = null,

    /// A structure that contains the X12 transaction set and version for the
    /// transformer output.
    format_options: ?FormatOptions = null,

    /// The format for the output from an outbound transformer: only X12 is
    /// currently supported.
    to_format: ToFormat,

    pub const json_field_names = .{
        .advanced_options = "advancedOptions",
        .format_options = "formatOptions",
        .to_format = "toFormat",
    };
};
