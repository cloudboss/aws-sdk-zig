const CaptureContentTypeHeader = @import("capture_content_type_header.zig").CaptureContentTypeHeader;
const CaptureOption = @import("capture_option.zig").CaptureOption;

/// Configuration to control how SageMaker AI captures inference data.
pub const DataCaptureConfig = struct {
    /// Configuration specifying how to treat different headers. If no headers are
    /// specified SageMaker AI will by default base64 encode when capturing the
    /// data.
    capture_content_type_header: ?CaptureContentTypeHeader = null,

    /// Specifies data Model Monitor will capture. You can configure whether to
    /// collect only input, only output, or both
    capture_options: []const CaptureOption,

    /// The Amazon S3 location used to capture the data.
    destination_s3_uri: []const u8,

    /// Whether data capture should be enabled or disabled (defaults to enabled).
    enable_capture: ?bool = null,

    /// The percentage of requests SageMaker AI will capture. A lower value is
    /// recommended for Endpoints with high traffic.
    initial_sampling_percentage: i32,

    /// The Amazon Resource Name (ARN) of an Key Management Service key that
    /// SageMaker AI uses to encrypt the captured data at rest using Amazon S3
    /// server-side encryption.
    ///
    /// The KmsKeyId can be any of the following formats:
    ///
    /// * Key ID: `1234abcd-12ab-34cd-56ef-1234567890ab`
    /// * Key ARN:
    ///   `arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab`
    /// * Alias name: `alias/ExampleAlias`
    /// * Alias name ARN: `arn:aws:kms:us-west-2:111122223333:alias/ExampleAlias`
    kms_key_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .capture_content_type_header = "CaptureContentTypeHeader",
        .capture_options = "CaptureOptions",
        .destination_s3_uri = "DestinationS3Uri",
        .enable_capture = "EnableCapture",
        .initial_sampling_percentage = "InitialSamplingPercentage",
        .kms_key_id = "KmsKeyId",
    };
};
