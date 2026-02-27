const RuleIpEmailAttribute = @import("rule_ip_email_attribute.zig").RuleIpEmailAttribute;

/// The IP address to evaluate for this condition.
pub const RuleIpToEvaluate = union(enum) {
    /// The attribute of the email to evaluate.
    attribute: ?RuleIpEmailAttribute,

    pub const json_field_names = .{
        .attribute = "Attribute",
    };
};
