const RecordExpiration = @import("record_expiration.zig").RecordExpiration;

/// The specified updates to the S3 Metadata journal table configuration.
pub const JournalTableConfigurationUpdates = struct {
    /// The journal table record expiration settings for the journal table.
    record_expiration: RecordExpiration,
};
