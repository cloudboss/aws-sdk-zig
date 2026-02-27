/// Describes a rule for an IP access control group.
pub const IpRuleItem = struct {
    /// The IP address range, in CIDR notation.
    ip_rule: ?[]const u8,

    /// The description.
    rule_desc: ?[]const u8,

    pub const json_field_names = .{
        .ip_rule = "ipRule",
        .rule_desc = "ruleDesc",
    };
};
