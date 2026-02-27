/// Specifies a single rule in a rule group whose action you want to override to
/// `Count`.
///
/// Instead of this option, use `RuleActionOverrides`. It accepts any valid
/// action setting, including `Count`.
pub const ExcludedRule = struct {
    /// The name of the rule whose action you want to override to `Count`.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};
