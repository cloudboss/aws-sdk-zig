const MetadataConfigurationResult = @import("metadata_configuration_result.zig").MetadataConfigurationResult;

/// The S3 Metadata configuration for a general purpose bucket.
pub const GetBucketMetadataConfigurationResult = struct {
    /// The metadata configuration for a general purpose bucket.
    metadata_configuration_result: MetadataConfigurationResult,
};
