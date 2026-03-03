const AssertionRule = @import("assertion_rule.zig").AssertionRule;
const GatingRule = @import("gating_rule.zig").GatingRule;

/// A safety rule. A safety rule can be an assertion rule or a gating rule.
pub const Rule = struct {
    /// An assertion rule enforces that, when a routing control state is changed,
    /// the criteria set by the rule configuration is met. Otherwise, the change to
    /// the routing control state is not accepted. For example, the criteria might
    /// be that at least one routing control state is On after the transaction so
    /// that traffic continues to flow to at least one cell for the application.
    /// This ensures that you avoid a fail-open scenario.
    assertion: ?AssertionRule = null,

    /// A gating rule verifies that a gating routing control or set of gating
    /// routing controls, evaluates as true, based on a rule configuration that you
    /// specify, which allows a set of routing control state changes to complete.
    ///
    /// For example, if you specify one gating routing control and you set the Type
    /// in the rule configuration to OR, that indicates that you must set the gating
    /// routing control to On for the rule to evaluate as true; that is, for the
    /// gating control "switch" to be "On". When you do that, then you can update
    /// the routing control states for the target routing controls that you specify
    /// in the gating rule.
    gating: ?GatingRule = null,

    pub const json_field_names = .{
        .assertion = "ASSERTION",
        .gating = "GATING",
    };
};
