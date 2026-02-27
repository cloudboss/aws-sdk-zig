const RetentionPeriod = @import("retention_period.zig").RetentionPeriod;

/// The retention policy for an email archive that specifies how long emails are
/// kept before being automatically deleted.
pub const ArchiveRetention = union(enum) {
    /// The enum value sets the period for retaining emails in an archive.
    retention_period: ?RetentionPeriod,

    pub const json_field_names = .{
        .retention_period = "RetentionPeriod",
    };
};
