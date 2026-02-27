/// The dollar value of the root cause.
pub const RootCauseImpact = struct {
    /// The dollar amount that this root cause contributed to the anomaly's
    /// TotalImpact.
    contribution: f64 = 0,

    pub const json_field_names = .{
        .contribution = "Contribution",
    };
};
