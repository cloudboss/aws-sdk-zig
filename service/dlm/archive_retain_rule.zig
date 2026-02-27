const RetentionArchiveTier = @import("retention_archive_tier.zig").RetentionArchiveTier;

/// **[Custom snapshot policies only]** Specifies information about the archive
/// storage tier retention period.
pub const ArchiveRetainRule = struct {
    /// Information about retention period in the Amazon EBS Snapshots Archive. For
    /// more information, see
    /// [Archive Amazon
    /// EBS
    /// snapshots](https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/snapshot-archive.html).
    retention_archive_tier: RetentionArchiveTier,

    pub const json_field_names = .{
        .retention_archive_tier = "RetentionArchiveTier",
    };
};
