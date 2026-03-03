const ConversationLevelTestResultsFilterBy = @import("conversation_level_test_results_filter_by.zig").ConversationLevelTestResultsFilterBy;
const TestResultTypeFilter = @import("test_result_type_filter.zig").TestResultTypeFilter;

/// Contains information about the method by which to filter the results of the
/// test execution.
pub const TestExecutionResultFilterBy = struct {
    /// Contains information about the method for filtering Conversation level test
    /// results.
    conversation_level_test_results_filter_by: ?ConversationLevelTestResultsFilterBy = null,

    /// Specifies which results to filter. See [Test result details">Test results
    /// details](https://docs.aws.amazon.com/lexv2/latest/dg/test-results-details-test-set.html)
    /// for details about different types of results.
    result_type_filter: TestResultTypeFilter,

    pub const json_field_names = .{
        .conversation_level_test_results_filter_by = "conversationLevelTestResultsFilterBy",
        .result_type_filter = "resultTypeFilter",
    };
};
