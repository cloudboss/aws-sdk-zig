/// The Add On ARN and its returned value that is evaluated in a policy
/// statement's conditional expression to either deny or block the incoming
/// email.
pub const IngressAnalysis = struct {
    /// The Amazon Resource Name (ARN) of an Add On.
    analyzer: []const u8,

    /// The returned value from an Add On.
    result_field: []const u8,

    pub const json_field_names = .{
        .analyzer = "Analyzer",
        .result_field = "ResultField",
    };
};
