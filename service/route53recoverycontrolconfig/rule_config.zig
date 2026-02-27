const RuleType = @import("rule_type.zig").RuleType;

/// The rule configuration for an assertion rule. That is, the criteria that you
/// set for specific assertion controls (routing controls) that specify how many
/// control states must be ON after a transaction completes.
pub const RuleConfig = struct {
    /// Logical negation of the rule. If the rule would usually evaluate true, it's
    /// evaluated as false, and vice versa.
    inverted: bool,

    /// The value of N, when you specify an ATLEAST rule type. That is, Threshold is
    /// the number of controls that must be set when you specify an ATLEAST type.
    threshold: i32,

    /// A rule can be one of the following: ATLEAST, AND, or OR.
    type: RuleType,

    pub const json_field_names = .{
        .inverted = "Inverted",
        .threshold = "Threshold",
        .type = "Type",
    };
};
