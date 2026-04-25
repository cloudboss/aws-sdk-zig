const DataBarsOptions = @import("data_bars_options.zig").DataBarsOptions;
const SparklinesOptions = @import("sparklines_options.zig").SparklinesOptions;

/// The inline visualization of a specific type to display within a chart.
pub const TableInlineVisualization = struct {
    /// The configuration of the inline visualization of the data bars within a
    /// chart.
    data_bars: ?DataBarsOptions = null,

    /// The configuration of the inline visualization of the sparklines within a
    /// chart.
    sparklines: ?SparklinesOptions = null,

    pub const json_field_names = .{
        .data_bars = "DataBars",
        .sparklines = "Sparklines",
    };
};
