const X12AdvancedOptions = @import("x12_advanced_options.zig").X12AdvancedOptions;

/// A structure that contains advanced options for EDI processing. Currently,
/// only X12 advanced options are supported.
pub const AdvancedOptions = struct {
    /// A structure that contains X12-specific advanced options, such as split
    /// options for processing X12 EDI files.
    x_12: ?X12AdvancedOptions = null,

    pub const json_field_names = .{
        .x_12 = "x12",
    };
};
