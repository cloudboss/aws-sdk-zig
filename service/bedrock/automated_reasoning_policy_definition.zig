const AutomatedReasoningPolicyDefinitionRule = @import("automated_reasoning_policy_definition_rule.zig").AutomatedReasoningPolicyDefinitionRule;
const AutomatedReasoningPolicyDefinitionType = @import("automated_reasoning_policy_definition_type.zig").AutomatedReasoningPolicyDefinitionType;
const AutomatedReasoningPolicyDefinitionVariable = @import("automated_reasoning_policy_definition_variable.zig").AutomatedReasoningPolicyDefinitionVariable;

/// Contains the formal logic rules, variables, and custom variable types that
/// define an Automated Reasoning policy. The policy definition specifies the
/// constraints used to validate foundation model responses for accuracy and
/// logical consistency.
pub const AutomatedReasoningPolicyDefinition = struct {
    /// The formal logic rules extracted from the source document. Rules define the
    /// logical constraints that determine whether model responses are valid,
    /// invalid, or satisfiable.
    rules: ?[]const AutomatedReasoningPolicyDefinitionRule = null,

    /// The custom user-defined vairable types used in the policy. Types are
    /// enum-based variable types that provide additional context beyond the
    /// predefined variable types.
    types: ?[]const AutomatedReasoningPolicyDefinitionType = null,

    /// The variables that represent concepts in the policy. Variables can have
    /// values assigned when translating natural language into formal logic. Their
    /// descriptions are crucial for accurate translation.
    variables: ?[]const AutomatedReasoningPolicyDefinitionVariable = null,

    /// The version of the policy definition format.
    version: []const u8 = "1",

    pub const json_field_names = .{
        .rules = "rules",
        .types = "types",
        .variables = "variables",
        .version = "version",
    };
};
