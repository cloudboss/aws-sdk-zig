const Visibility = @import("visibility.zig").Visibility;

/// The options that determine how a date axis is displayed.
pub const DateAxisOptions = struct {
    /// Determines whether or not missing dates are displayed.
    missing_date_visibility: ?Visibility,

    pub const json_field_names = .{
        .missing_date_visibility = "MissingDateVisibility",
    };
};
