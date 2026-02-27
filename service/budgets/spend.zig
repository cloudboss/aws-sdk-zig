/// The amount of cost or usage that's measured for a budget.
///
/// *Cost example:* A `Spend` for `3 USD` of
/// costs has the following parameters:
///
/// * An `Amount` of `3`
///
/// * A `Unit` of `USD`
///
/// *Usage example:* A `Spend` for `3 GB` of S3
/// usage has the following parameters:
///
/// * An `Amount` of `3`
///
/// * A `Unit` of `GB`
pub const Spend = struct {
    /// The cost or usage amount that's associated with a budget forecast, actual
    /// spend, or
    /// budget threshold.
    amount: []const u8,

    /// The unit of measurement that's used for the budget forecast, actual spend,
    /// or budget
    /// threshold.
    unit: []const u8,

    pub const json_field_names = .{
        .amount = "Amount",
        .unit = "Unit",
    };
};
