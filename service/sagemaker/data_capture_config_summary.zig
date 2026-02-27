const CaptureStatus = @import("capture_status.zig").CaptureStatus;

/// The currently active data capture configuration used by your Endpoint.
pub const DataCaptureConfigSummary = struct {
    /// Whether data capture is currently functional.
    capture_status: CaptureStatus,

    /// The percentage of requests being captured by your Endpoint.
    current_sampling_percentage: i32,

    /// The Amazon S3 location being used to capture the data.
    destination_s3_uri: []const u8,

    /// Whether data capture is enabled or disabled.
    enable_capture: bool,

    /// The KMS key being used to encrypt the data in Amazon S3.
    kms_key_id: []const u8,

    pub const json_field_names = .{
        .capture_status = "CaptureStatus",
        .current_sampling_percentage = "CurrentSamplingPercentage",
        .destination_s3_uri = "DestinationS3Uri",
        .enable_capture = "EnableCapture",
        .kms_key_id = "KmsKeyId",
    };
};
