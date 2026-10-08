/// A reference to either a template or a rule in a create or update request.
/// Set exactly one of `templateIdentifier` or `ruleIdentifier`.
pub const TemplateOrRuleReference = union(enum) {
    /// The identifier of the rule. This is the rule's Amazon Resource Name (ARN).
    rule_identifier: ?[]const u8,
    /// The identifier of the template. This is the template's Amazon Resource Name
    /// (ARN).
    template_identifier: ?[]const u8,

    pub const json_field_names = .{
        .rule_identifier = "ruleIdentifier",
        .template_identifier = "templateIdentifier",
    };
};
