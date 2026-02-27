const CaptureContentTypeHeader = @import("capture_content_type_header.zig").CaptureContentTypeHeader;

/// The Amazon S3 location and configuration for storing inference request and
/// response data.
pub const InferenceExperimentDataStorageConfig = struct {
    content_type: ?CaptureContentTypeHeader,

    /// The Amazon S3 bucket where the inference request and response data is
    /// stored.
    destination: []const u8,

    /// The Amazon Web Services Key Management Service key that Amazon SageMaker
    /// uses to encrypt captured data at rest using Amazon S3 server-side
    /// encryption.
    kms_key: ?[]const u8,

    pub const json_field_names = .{
        .content_type = "ContentType",
        .destination = "Destination",
        .kms_key = "KmsKey",
    };
};
