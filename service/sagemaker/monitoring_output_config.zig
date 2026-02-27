const MonitoringOutput = @import("monitoring_output.zig").MonitoringOutput;

/// The output configuration for monitoring jobs.
pub const MonitoringOutputConfig = struct {
    /// The Key Management Service (KMS) key that Amazon SageMaker AI uses to
    /// encrypt the model artifacts at rest using Amazon S3 server-side encryption.
    kms_key_id: ?[]const u8,

    /// Monitoring outputs for monitoring jobs. This is where the output of the
    /// periodic monitoring jobs is uploaded.
    monitoring_outputs: []const MonitoringOutput,

    pub const json_field_names = .{
        .kms_key_id = "KmsKeyId",
        .monitoring_outputs = "MonitoringOutputs",
    };
};
