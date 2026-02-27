const SeverityCounts = @import("severity_counts.zig").SeverityCounts;

/// Contains counts of vulnerability findings from image scans that run when you
/// create
/// new Image Builder images, or build new versions of existing images. The
/// vulnerability counts are
/// grouped by severity level. The counts are aggregated across resources to
/// create the
/// final tally for the account that owns them.
pub const AccountAggregation = struct {
    /// Identifies the account that owns the aggregated resource findings.
    account_id: ?[]const u8,

    /// Counts by severity level for medium severity and higher level findings, plus
    /// a total
    /// for all of the findings.
    severity_counts: ?SeverityCounts,

    pub const json_field_names = .{
        .account_id = "accountId",
        .severity_counts = "severityCounts",
    };
};
