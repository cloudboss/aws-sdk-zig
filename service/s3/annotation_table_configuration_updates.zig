const AnnotationConfigurationState = @import("annotation_configuration_state.zig").AnnotationConfigurationState;
const MetadataTableEncryptionConfiguration = @import("metadata_table_encryption_configuration.zig").MetadataTableEncryptionConfiguration;

/// Specifies updates to apply to the annotation table configuration. Used as
/// the request body for
/// `UpdateBucketMetadataAnnotationTableConfiguration`.
pub const AnnotationTableConfigurationUpdates = struct {
    /// The new configuration state to apply.
    configuration_state: AnnotationConfigurationState,

    encryption_configuration: ?MetadataTableEncryptionConfiguration = null,

    /// The new IAM role ARN to apply.
    role: ?[]const u8 = null,
};
