/// Configuration for threshold settings that determine when values near
/// expected values should be ignored during anomaly detection.
pub const IgnoreNearExpected = union(enum) {
    /// The absolute amount by which values can differ from expected values before
    /// being considered anomalous.
    amount: ?f64,
    /// The ratio by which values can differ from expected values before being
    /// considered anomalous.
    ratio: ?f64,

    pub const json_field_names = .{
        .amount = "amount",
        .ratio = "ratio",
    };
};
