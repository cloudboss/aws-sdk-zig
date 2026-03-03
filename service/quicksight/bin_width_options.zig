/// The options that determine the bin width of a histogram.
pub const BinWidthOptions = struct {
    /// The options that determine the bin count limit.
    bin_count_limit: ?i64 = null,

    /// The options that determine the bin width value.
    value: ?f64 = null,

    pub const json_field_names = .{
        .bin_count_limit = "BinCountLimit",
        .value = "Value",
    };
};
