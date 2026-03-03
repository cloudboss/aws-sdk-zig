const PercentVisibleRange = @import("percent_visible_range.zig").PercentVisibleRange;

/// The range options for the data zoom scroll bar.
pub const VisibleRangeOptions = struct {
    /// The percent range in the visible range.
    percent_range: ?PercentVisibleRange = null,

    pub const json_field_names = .{
        .percent_range = "PercentRange",
    };
};
