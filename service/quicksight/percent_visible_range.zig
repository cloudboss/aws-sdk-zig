/// The percent range in the visible range.
pub const PercentVisibleRange = struct {
    /// The lower bound of the range.
    from: ?f64 = null,

    /// The top bound of the range.
    to: ?f64 = null,

    pub const json_field_names = .{
        .from = "From",
        .to = "To",
    };
};
