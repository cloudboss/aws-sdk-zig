/// Input data for case summarization.
pub const CaseSummarizationInputData = struct {
    /// The Amazon Resource Name (ARN) of the case for summarization.
    case_arn: []const u8,

    pub const json_field_names = .{
        .case_arn = "caseArn",
    };
};
