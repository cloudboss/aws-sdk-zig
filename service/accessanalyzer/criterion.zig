/// The criteria to use in the filter that defines the archive rule. For more
/// information on available filter keys, see [IAM Access Analyzer filter
/// keys](https://docs.aws.amazon.com/IAM/latest/UserGuide/access-analyzer-reference-filter-keys.html).
pub const Criterion = struct {
    /// A "contains" operator to match for the filter used to create the rule.
    contains: ?[]const []const u8,

    /// An "equals" operator to match for the filter used to create the rule.
    eq: ?[]const []const u8,

    /// An "exists" operator to match for the filter used to create the rule.
    exists: ?bool,

    /// A "not equals" operator to match for the filter used to create the rule.
    neq: ?[]const []const u8,

    pub const json_field_names = .{
        .contains = "contains",
        .eq = "eq",
        .exists = "exists",
        .neq = "neq",
    };
};
