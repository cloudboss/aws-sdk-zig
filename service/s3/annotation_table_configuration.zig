const AnnotationConfigurationState = @import("annotation_configuration_state.zig").AnnotationConfigurationState;
const MetadataTableEncryptionConfiguration = @import("metadata_table_encryption_configuration.zig").MetadataTableEncryptionConfiguration;

/// Specifies the configuration for the annotation table associated with a
/// bucket's Amazon S3 Metadata
/// configuration. The annotation table is an Iceberg table that records
/// annotation events for objects
/// in the bucket.
pub const AnnotationTableConfiguration = struct {
    /// The state of the annotation table. Valid values are `ENABLED` and
    /// `DISABLED`.
    configuration_state: AnnotationConfigurationState,

    encryption_configuration: ?MetadataTableEncryptionConfiguration = null,

    /// The ARN of the IAM role used to manage the annotation table.
    role: ?[]const u8 = null,
};
