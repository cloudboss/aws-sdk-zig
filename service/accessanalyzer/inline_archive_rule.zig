const aws = @import("aws");

const Criterion = @import("criterion.zig").Criterion;

/// An criterion statement in an archive rule. Each archive rule may have
/// multiple criteria.
pub const InlineArchiveRule = struct {
    /// The condition and values for a criterion.
    filter: []const aws.map.MapEntry(Criterion),

    /// The name of the rule.
    rule_name: []const u8,

    pub const json_field_names = .{
        .filter = "filter",
        .rule_name = "ruleName",
    };
};
