/// A number filter for querying findings.
pub const NumberFilter = struct {
    /// The equal-to condition to be applied to a single field when querying for
    /// findings.
    eq: ?f64 = null,

    /// The greater-than condition to be applied to a single field when querying for
    /// findings.
    gt: ?f64 = null,

    /// The greater-than-equal condition to be applied to a single field when
    /// querying for
    /// findings.
    gte: ?f64 = null,

    /// The less-than condition to be applied to a single field when querying for
    /// findings.
    lt: ?f64 = null,

    /// The less-than-equal condition to be applied to a single field when querying
    /// for
    /// findings.
    lte: ?f64 = null,

    pub const json_field_names = .{
        .eq = "Eq",
        .gt = "Gt",
        .gte = "Gte",
        .lt = "Lt",
        .lte = "Lte",
    };
};
