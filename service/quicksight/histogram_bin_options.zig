const BinCountOptions = @import("bin_count_options.zig").BinCountOptions;
const BinWidthOptions = @import("bin_width_options.zig").BinWidthOptions;
const HistogramBinType = @import("histogram_bin_type.zig").HistogramBinType;

/// The options that determine the presentation of histogram bins.
pub const HistogramBinOptions = struct {
    /// The options that determine the bin count of a histogram.
    bin_count: ?BinCountOptions,

    /// The options that determine the bin width of a histogram.
    bin_width: ?BinWidthOptions,

    /// The options that determine the selected bin type.
    selected_bin_type: ?HistogramBinType,

    /// The options that determine the bin start value.
    start_value: ?f64,

    pub const json_field_names = .{
        .bin_count = "BinCount",
        .bin_width = "BinWidth",
        .selected_bin_type = "SelectedBinType",
        .start_value = "StartValue",
    };
};
