/// A return-on-investment estimate with context.
pub const Roi = struct {
    /// A sentence providing context for the estimate.
    detail: []const u8,

    /// A short statistic or key metric. Optional when there is no quantifiable
    /// figure.
    estimate: ?[]const u8 = null,

    pub const json_field_names = .{
        .detail = "detail",
        .estimate = "estimate",
    };
};
