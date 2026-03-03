/// The options that determine the bin count of a histogram.
pub const BinCountOptions = struct {
    /// The options that determine the bin count value.
    value: ?i32 = null,

    pub const json_field_names = .{
        .value = "Value",
    };
};
