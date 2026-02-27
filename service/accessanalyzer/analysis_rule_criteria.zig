const aws = @import("aws");

/// The criteria for an analysis rule for an analyzer. The criteria determine
/// which entities will generate findings.
pub const AnalysisRuleCriteria = struct {
    /// A list of Amazon Web Services account IDs to apply to the analysis rule
    /// criteria. The accounts cannot include the organization analyzer owner
    /// account. Account IDs can only be applied to the analysis rule criteria for
    /// organization-level analyzers. The list cannot include more than 2,000
    /// account IDs.
    account_ids: ?[]const []const u8,

    /// An array of key-value pairs to match for your resources. You can use the set
    /// of Unicode letters, digits, whitespace, `_`, `.`, `/`, `=`, `+`, and `-`.
    ///
    /// For the tag key, you can specify a value that is 1 to 128 characters in
    /// length and cannot be prefixed with `aws:`.
    ///
    /// For the tag value, you can specify a value that is 0 to 256 characters in
    /// length. If the specified tag value is 0 characters, the rule is applied to
    /// all principals with the specified tag key.
    resource_tags: ?[]const []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .account_ids = "accountIds",
        .resource_tags = "resourceTags",
    };
};
