const DataBarsOptions = @import("data_bars_options.zig").DataBarsOptions;

/// The inline visualization of a specific type to display within a chart.
pub const TableInlineVisualization = struct {
    /// The configuration of the inline visualization of the data bars within a
    /// chart.
    data_bars: ?DataBarsOptions,

    pub const json_field_names = .{
        .data_bars = "DataBars",
    };
};
