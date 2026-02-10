const MetadataTableEncryptionConfiguration = @import("metadata_table_encryption_configuration.zig").MetadataTableEncryptionConfiguration;
const RecordExpiration = @import("record_expiration.zig").RecordExpiration;

/// The journal table configuration for an S3 Metadata configuration.
pub const JournalTableConfiguration = struct {
    /// The encryption configuration for the journal table.
    encryption_configuration: ?MetadataTableEncryptionConfiguration,

    /// The journal table record expiration settings for the journal table.
    record_expiration: RecordExpiration,
};
