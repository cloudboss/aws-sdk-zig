const ArchiveRetainRule = @import("archive_retain_rule.zig").ArchiveRetainRule;

/// **[Custom snapshot policies only]** Specifies a snapshot archiving rule for
/// a schedule.
pub const ArchiveRule = struct {
    /// Information about the retention period for the snapshot archiving rule.
    retain_rule: ArchiveRetainRule,

    pub const json_field_names = .{
        .retain_rule = "RetainRule",
    };
};
