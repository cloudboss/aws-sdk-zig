const aws = @import("aws");

const Criterion = @import("criterion.zig").Criterion;

/// Contains information about an archive rule. Archive rules automatically
/// archive new findings that meet the criteria you define when you create the
/// rule.
pub const ArchiveRuleSummary = struct {
    /// The time at which the archive rule was created.
    created_at: i64,

    /// A filter used to define the archive rule.
    filter: []const aws.map.MapEntry(Criterion),

    /// The name of the archive rule.
    rule_name: []const u8,

    /// The time at which the archive rule was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .filter = "filter",
        .rule_name = "ruleName",
        .updated_at = "updatedAt",
    };
};
