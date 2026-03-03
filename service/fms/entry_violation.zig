const EntryDescription = @import("entry_description.zig").EntryDescription;
const EntryViolationReason = @import("entry_violation_reason.zig").EntryViolationReason;

/// Detailed information about an entry violation in a network ACL. The
/// violation is against the network ACL specification inside the
/// Firewall Manager network ACL policy. This data object is part of
/// `InvalidNetworkAclEntriesViolation`.
pub const EntryViolation = struct {
    /// The evaluation location within the ordered list of entries where the
    /// `ExpectedEntry` is currently located.
    actual_evaluation_order: ?[]const u8 = null,

    /// The list of entries that are in conflict with `ExpectedEntry`.
    entries_with_conflicts: ?[]const EntryDescription = null,

    /// The entry that's currently in the `ExpectedEvaluationOrder` location, in
    /// place of the expected entry.
    entry_at_expected_evaluation_order: ?EntryDescription = null,

    /// Descriptions of the violations that Firewall Manager found for these
    /// entries.
    entry_violation_reasons: ?[]const EntryViolationReason = null,

    /// The Firewall Manager-managed network ACL entry that is involved in the entry
    /// violation.
    expected_entry: ?EntryDescription = null,

    /// The evaluation location within the ordered list of entries where the
    /// `ExpectedEntry` should be, according to the network ACL policy
    /// specifications.
    expected_evaluation_order: ?[]const u8 = null,

    pub const json_field_names = .{
        .actual_evaluation_order = "ActualEvaluationOrder",
        .entries_with_conflicts = "EntriesWithConflicts",
        .entry_at_expected_evaluation_order = "EntryAtExpectedEvaluationOrder",
        .entry_violation_reasons = "EntryViolationReasons",
        .expected_entry = "ExpectedEntry",
        .expected_evaluation_order = "ExpectedEvaluationOrder",
    };
};
