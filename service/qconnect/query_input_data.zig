const CaseSummarizationInputData = @import("case_summarization_input_data.zig").CaseSummarizationInputData;
const IntentInputData = @import("intent_input_data.zig").IntentInputData;
const QueryTextInputData = @import("query_text_input_data.zig").QueryTextInputData;

/// Input information for the query.
pub const QueryInputData = union(enum) {
    /// Input data for case summarization queries.
    case_summarization_input_data: ?CaseSummarizationInputData,
    /// Input information for the intent.
    intent_input_data: ?IntentInputData,
    /// Input information for the query.
    query_text_input_data: ?QueryTextInputData,

    pub const json_field_names = .{
        .case_summarization_input_data = "caseSummarizationInputData",
        .intent_input_data = "intentInputData",
        .query_text_input_data = "queryTextInputData",
    };
};
