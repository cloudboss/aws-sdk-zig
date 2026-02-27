/// Use EvaluationContext to group independently initiated proactive resource
/// evaluations. For example, CFN Stack.
/// If you want to check just a resource definition, you do not need to provide
/// evaluation context.
pub const EvaluationContext = struct {
    /// A unique EvaluationContextIdentifier ID for an EvaluationContext.
    evaluation_context_identifier: ?[]const u8,

    pub const json_field_names = .{
        .evaluation_context_identifier = "EvaluationContextIdentifier",
    };
};
