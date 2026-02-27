pub const HistogramBinType = enum {
    bin_count,
    bin_width,

    pub const json_field_names = .{
        .bin_count = "BIN_COUNT",
        .bin_width = "BIN_WIDTH",
    };
};
