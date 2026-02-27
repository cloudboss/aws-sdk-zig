pub const PipelineExecutionStartCondition = enum {
    expression_match_only,
    expression_match_and_dependency_updates_available,

    pub const json_field_names = .{
        .expression_match_only = "EXPRESSION_MATCH_ONLY",
        .expression_match_and_dependency_updates_available = "EXPRESSION_MATCH_AND_DEPENDENCY_UPDATES_AVAILABLE",
    };
};
