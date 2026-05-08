/// Statistics for the control variant in an A/B test.
pub const ControlStats = struct {
    /// The mean evaluation score for the control variant.
    mean: f64,

    /// The number of sessions evaluated for the control variant.
    sample_size: i32,

    /// The name of the control variant.
    variant_name: []const u8,

    pub const json_field_names = .{
        .mean = "mean",
        .sample_size = "sampleSize",
        .variant_name = "variantName",
    };
};
