const ProcessingOutput = @import("processing_output.zig").ProcessingOutput;

/// Configuration for uploading output from the processing container.
pub const ProcessingOutputConfig = struct {
    /// The Amazon Web Services Key Management Service (Amazon Web Services KMS) key
    /// that Amazon SageMaker uses to encrypt the processing job output. `KmsKeyId`
    /// can be an ID of a KMS key, ARN of a KMS key, or alias of a KMS key. The
    /// `KmsKeyId` is applied to all outputs.
    kms_key_id: ?[]const u8 = null,

    /// An array of outputs configuring the data to upload from the processing
    /// container.
    outputs: []const ProcessingOutput,

    pub const json_field_names = .{
        .kms_key_id = "KmsKeyId",
        .outputs = "Outputs",
    };
};
