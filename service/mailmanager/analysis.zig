/// The result of an analysis can be used in conditions to trigger actions.
/// Analyses can inspect the email content and report a certain aspect of the
/// email.
pub const Analysis = struct {
    /// The Amazon Resource Name (ARN) of an Add On.
    analyzer: []const u8,

    /// The returned value from an Add On.
    result_field: []const u8,

    pub const json_field_names = .{
        .analyzer = "Analyzer",
        .result_field = "ResultField",
    };
};
