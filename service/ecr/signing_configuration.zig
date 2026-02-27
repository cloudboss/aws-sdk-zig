const SigningRule = @import("signing_rule.zig").SigningRule;

/// The signing configuration for a registry, which specifies rules
/// for automatically signing images when pushed.
pub const SigningConfiguration = struct {
    /// A list of signing rules. Each rule defines a signing profile and optional
    /// repository
    /// filters that determine which images are automatically signed. Maximum of 10
    /// rules.
    rules: []const SigningRule,

    pub const json_field_names = .{
        .rules = "rules",
    };
};
