const FilterRule = @import("filter_rule.zig").FilterRule;

/// A container for object key name prefix and suffix filtering rules.
pub const S3KeyFilter = struct {
    filter_rules: ?[]const FilterRule = null,
};
