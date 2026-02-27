const MappingRuleMatchType = @import("mapping_rule_match_type.zig").MappingRuleMatchType;

/// A rule that maps a claim name, a claim value, and a match type to a role
/// ARN.
pub const MappingRule = struct {
    /// The claim name that must be present in the token, for example, "isAdmin" or
    /// "paid".
    claim: []const u8,

    /// The match condition that specifies how closely the claim value in the IdP
    /// token must
    /// match `Value`.
    match_type: MappingRuleMatchType,

    /// The role ARN.
    role_arn: []const u8,

    /// A brief string that the claim must match, for example, "paid" or "yes".
    value: []const u8,

    pub const json_field_names = .{
        .claim = "Claim",
        .match_type = "MatchType",
        .role_arn = "RoleARN",
        .value = "Value",
    };
};
