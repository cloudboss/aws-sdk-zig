const ConditionalRule = @import("conditional_rule.zig").ConditionalRule;

/// The set of conditional rules that determine a field's resolved requirement
/// based on the values of other fields in the same registration form. Attached
/// to fields whose **FieldRequirement** is **CONDITIONAL**.
///
/// Evaluation proceeds top-to-bottom through **Rules**. The first rule whose
/// conditions all evaluate to true wins and its behavior is returned. If no
/// rule matches, the **DefaultBehavior** is returned.
pub const ConditionalBehavior = struct {
    /// The field behavior that applies when no conditional rule in **Rules**
    /// matches. Valid values are **REQUIRED**, **OPTIONAL**, and **DISALLOWED**.
    default_behavior: []const u8,

    /// An ordered list of conditional rules. Rules are evaluated top-to-bottom and
    /// the first rule whose conditions all evaluate to true determines the field's
    /// behavior. Rules whose conditions do not all match are skipped and evaluation
    /// continues to the next rule.
    rules: []const ConditionalRule,

    pub const json_field_names = .{
        .default_behavior = "DefaultBehavior",
        .rules = "Rules",
    };
};
