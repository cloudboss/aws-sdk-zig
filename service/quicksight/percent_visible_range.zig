/// The percent range in the visible range.
pub const PercentVisibleRange = struct {
    /// The lower bound of the range.
    from: ?f64,

    /// The top bound of the range.
    to: ?f64,

    pub const json_field_names = .{
        .from = "From",
        .to = "To",
    };
};
