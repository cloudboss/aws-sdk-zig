/// The consumed usage for the resource.
pub const ConsumedUsages = struct {
    /// The amount of the budget consumed.
    approximate_dollar_usage: f32,

    pub const json_field_names = .{
        .approximate_dollar_usage = "approximateDollarUsage",
    };
};
