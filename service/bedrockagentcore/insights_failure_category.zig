const std = @import("std");

/// Failure category taxonomy for agent session insights.
/// Values must stay in sync with the category registry in AgentCoreLens
/// (amzn_agentcore_lens.config.failure_detection.FAILURE_CATEGORIES).
pub const InsightsFailureCategory = enum {
    execution_error_authentication,
    execution_error_resource_not_found,
    execution_error_service_errors,
    execution_error_rate_limiting,
    execution_error_formatting,
    execution_error_timeout,
    execution_error_resource_exhaustion,
    execution_error_environment,
    execution_error_tool_schema,
    task_instruction_non_compliance,
    task_instruction_problem_id,
    incorrect_actions_tool_selection,
    incorrect_actions_poor_information_retrieval,
    incorrect_actions_clarification,
    incorrect_actions_inappropriate_info_request,
    context_handling_failures,
    hallucination_capabilities,
    hallucination_misunderstand,
    hallucination_usage,
    hallucination_history,
    hallucination_params,
    hallucination_fabricate_tool_outputs,
    repetitive_behavior_tool,
    repetitive_behavior_info,
    repetitive_behavior_step,
    orchestration_reasoning_mismatch,
    orchestration_goal_deviation,
    orchestration_premature_termination,
    orchestration_unaware_termination,
    llm_output_nonsensical,
    configuration_mismatch_tool_definition,
    coding_edge_case_oversights,
    coding_dependency_issues,
    other,

    pub const json_field_names = .{
        .execution_error_authentication = "execution-error-category-authentication",
        .execution_error_resource_not_found = "execution-error-category-resource-not-found",
        .execution_error_service_errors = "execution-error-category-service-errors",
        .execution_error_rate_limiting = "execution-error-category-rate-limiting",
        .execution_error_formatting = "execution-error-category-formatting",
        .execution_error_timeout = "execution-error-category-timeout",
        .execution_error_resource_exhaustion = "execution-error-category-resource-exhaustion",
        .execution_error_environment = "execution-error-category-environment",
        .execution_error_tool_schema = "execution-error-category-tool-schema",
        .task_instruction_non_compliance = "task-instruction-category-non-compliance",
        .task_instruction_problem_id = "task-instruction-category-problem-id",
        .incorrect_actions_tool_selection = "incorrect-actions-category-tool-selection",
        .incorrect_actions_poor_information_retrieval = "incorrect-actions-category-poor-information-retrieval",
        .incorrect_actions_clarification = "incorrect-actions-category-clarification",
        .incorrect_actions_inappropriate_info_request = "incorrect-actions-category-inappropriate-info-request",
        .context_handling_failures = "context-handling-error-category-context-handling-failures",
        .hallucination_capabilities = "hallucination-category-hall-capabilities",
        .hallucination_misunderstand = "hallucination-category-hall-misunderstand",
        .hallucination_usage = "hallucination-category-hall-usage",
        .hallucination_history = "hallucination-category-hall-history",
        .hallucination_params = "hallucination-category-hall-params",
        .hallucination_fabricate_tool_outputs = "hallucination-category-fabricate-tool-outputs",
        .repetitive_behavior_tool = "repetitive-behavior-category-repetition-tool",
        .repetitive_behavior_info = "repetitive-behavior-category-repetition-info",
        .repetitive_behavior_step = "repetitive-behavior-category-step-repetition",
        .orchestration_reasoning_mismatch = "orchestration-related-errors-category-reasoning-mismatch",
        .orchestration_goal_deviation = "orchestration-related-errors-category-goal-deviation",
        .orchestration_premature_termination = "orchestration-related-errors-category-premature-termination",
        .orchestration_unaware_termination = "orchestration-related-errors-category-unaware-termination",
        .llm_output_nonsensical = "llm-output-category-nonsensical",
        .configuration_mismatch_tool_definition = "configuration-mismatch-category-tool-definition",
        .coding_edge_case_oversights = "coding-use-case-specific-failure-types-category-edge-case-oversights",
        .coding_dependency_issues = "coding-use-case-specific-failure-types-category-dependency-issues",
        .other = "other",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .execution_error_authentication => "execution-error-category-authentication",
            .execution_error_resource_not_found => "execution-error-category-resource-not-found",
            .execution_error_service_errors => "execution-error-category-service-errors",
            .execution_error_rate_limiting => "execution-error-category-rate-limiting",
            .execution_error_formatting => "execution-error-category-formatting",
            .execution_error_timeout => "execution-error-category-timeout",
            .execution_error_resource_exhaustion => "execution-error-category-resource-exhaustion",
            .execution_error_environment => "execution-error-category-environment",
            .execution_error_tool_schema => "execution-error-category-tool-schema",
            .task_instruction_non_compliance => "task-instruction-category-non-compliance",
            .task_instruction_problem_id => "task-instruction-category-problem-id",
            .incorrect_actions_tool_selection => "incorrect-actions-category-tool-selection",
            .incorrect_actions_poor_information_retrieval => "incorrect-actions-category-poor-information-retrieval",
            .incorrect_actions_clarification => "incorrect-actions-category-clarification",
            .incorrect_actions_inappropriate_info_request => "incorrect-actions-category-inappropriate-info-request",
            .context_handling_failures => "context-handling-error-category-context-handling-failures",
            .hallucination_capabilities => "hallucination-category-hall-capabilities",
            .hallucination_misunderstand => "hallucination-category-hall-misunderstand",
            .hallucination_usage => "hallucination-category-hall-usage",
            .hallucination_history => "hallucination-category-hall-history",
            .hallucination_params => "hallucination-category-hall-params",
            .hallucination_fabricate_tool_outputs => "hallucination-category-fabricate-tool-outputs",
            .repetitive_behavior_tool => "repetitive-behavior-category-repetition-tool",
            .repetitive_behavior_info => "repetitive-behavior-category-repetition-info",
            .repetitive_behavior_step => "repetitive-behavior-category-step-repetition",
            .orchestration_reasoning_mismatch => "orchestration-related-errors-category-reasoning-mismatch",
            .orchestration_goal_deviation => "orchestration-related-errors-category-goal-deviation",
            .orchestration_premature_termination => "orchestration-related-errors-category-premature-termination",
            .orchestration_unaware_termination => "orchestration-related-errors-category-unaware-termination",
            .llm_output_nonsensical => "llm-output-category-nonsensical",
            .configuration_mismatch_tool_definition => "configuration-mismatch-category-tool-definition",
            .coding_edge_case_oversights => "coding-use-case-specific-failure-types-category-edge-case-oversights",
            .coding_dependency_issues => "coding-use-case-specific-failure-types-category-dependency-issues",
            .other => "other",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
