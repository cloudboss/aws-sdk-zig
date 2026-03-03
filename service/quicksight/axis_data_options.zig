const DateAxisOptions = @import("date_axis_options.zig").DateAxisOptions;
const NumericAxisOptions = @import("numeric_axis_options.zig").NumericAxisOptions;

/// The data options for an axis.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const AxisDataOptions = struct {
    /// The options for an axis with a date field.
    date_axis_options: ?DateAxisOptions = null,

    /// The options for an axis with a numeric field.
    numeric_axis_options: ?NumericAxisOptions = null,

    pub const json_field_names = .{
        .date_axis_options = "DateAxisOptions",
        .numeric_axis_options = "NumericAxisOptions",
    };
};
