const DisplayFormat = @import("display_format.zig").DisplayFormat;
const DisplayFormatOptions = @import("display_format_options.zig").DisplayFormatOptions;

/// A structure that represents a default formatting definition.
pub const DefaultFormatting = struct {
    /// The display format. Valid values for this structure are `AUTO`,
    /// `PERCENT`, `CURRENCY`, `NUMBER`, `DATE`, and
    /// `STRING`.
    display_format: ?DisplayFormat,

    /// The additional options for display formatting.
    display_format_options: ?DisplayFormatOptions,

    pub const json_field_names = .{
        .display_format = "DisplayFormat",
        .display_format_options = "DisplayFormatOptions",
    };
};
