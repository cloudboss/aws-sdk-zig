const AutoMLJobObjective = @import("auto_ml_job_objective.zig").AutoMLJobObjective;
const AutoMLProblemTypeResolvedAttributes = @import("auto_ml_problem_type_resolved_attributes.zig").AutoMLProblemTypeResolvedAttributes;
const AutoMLJobCompletionCriteria = @import("auto_ml_job_completion_criteria.zig").AutoMLJobCompletionCriteria;

/// The resolved attributes used to configure an AutoML job V2.
pub const AutoMLResolvedAttributes = struct {
    auto_ml_job_objective: ?AutoMLJobObjective,

    /// Defines the resolved attributes specific to a problem type.
    auto_ml_problem_type_resolved_attributes: ?AutoMLProblemTypeResolvedAttributes,

    completion_criteria: ?AutoMLJobCompletionCriteria,

    pub const json_field_names = .{
        .auto_ml_job_objective = "AutoMLJobObjective",
        .auto_ml_problem_type_resolved_attributes = "AutoMLProblemTypeResolvedAttributes",
        .completion_criteria = "CompletionCriteria",
    };
};
