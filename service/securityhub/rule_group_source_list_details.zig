/// Stateful inspection criteria for a domain list rule group.
pub const RuleGroupSourceListDetails = struct {
    /// Indicates whether to allow or deny access to the domains listed in
    /// `Targets`.
    generated_rules_type: ?[]const u8 = null,

    /// The domains that you want to inspect for in your traffic flows. You can
    /// provide full domain names, or use the '.' prefix as a wildcard. For example,
    /// `.example.com` matches all domains that end with `example.com`.
    targets: ?[]const []const u8 = null,

    /// The protocols that you want to inspect. Specify `LS_SNI` for HTTPS. Specify
    /// `HTTP_HOST` for HTTP. You can specify either or both.
    target_types: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .generated_rules_type = "GeneratedRulesType",
        .targets = "Targets",
        .target_types = "TargetTypes",
    };
};
