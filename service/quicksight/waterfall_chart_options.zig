/// The options that determine the presentation of a waterfall visual.
pub const WaterfallChartOptions = struct {
    /// This option determines the total bar label of a waterfall visual.
    total_bar_label: ?[]const u8,

    pub const json_field_names = .{
        .total_bar_label = "TotalBarLabel",
    };
};
