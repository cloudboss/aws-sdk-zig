const AssemblyType = @import("assembly_type.zig").AssemblyType;

/// Describes the results of a transform job.
pub const TransformOutput = struct {
    /// The MIME type used to specify the output data. Amazon SageMaker uses the
    /// MIME type with each http call to transfer data from the transform job.
    accept: ?[]const u8,

    /// Defines how to assemble the results of the transform job as a single S3
    /// object. Choose a format that is most convenient to you. To concatenate the
    /// results in binary format, specify `None`. To add a newline character at the
    /// end of every transformed record, specify `Line`.
    assemble_with: ?AssemblyType,

    /// The Amazon Web Services Key Management Service (Amazon Web Services KMS) key
    /// that Amazon SageMaker uses to encrypt the model artifacts at rest using
    /// Amazon S3 server-side encryption. The `KmsKeyId` can be any of the following
    /// formats:
    ///
    /// * Key ID: `1234abcd-12ab-34cd-56ef-1234567890ab`
    /// * Key ARN:
    ///   `arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab`
    /// * Alias name: `alias/ExampleAlias`
    /// * Alias name ARN: `arn:aws:kms:us-west-2:111122223333:alias/ExampleAlias`
    ///
    /// If you don't provide a KMS key ID, Amazon SageMaker uses the default KMS key
    /// for Amazon S3 for your role's account. For more information, see
    /// [KMS-Managed Encryption
    /// Keys](https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingKMSEncryption.html) in the *Amazon Simple Storage Service Developer Guide.*
    ///
    /// The KMS key policy must grant permission to the IAM role that you specify in
    /// your
    /// [CreateModel](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateModel.html) request. For more information, see [Using Key Policies in Amazon Web Services KMS](https://docs.aws.amazon.com/kms/latest/developerguide/key-policies.html) in the *Amazon Web Services Key Management Service Developer Guide*.
    kms_key_id: ?[]const u8,

    /// The Amazon S3 path where you want Amazon SageMaker to store the results of
    /// the transform job. For example, `s3://bucket-name/key-name-prefix`.
    ///
    /// For every S3 object used as input for the transform job, batch transform
    /// stores the transformed data with an .`out` suffix in a corresponding
    /// subfolder in the location in the output prefix. For example, for the input
    /// data stored at `s3://bucket-name/input-name-prefix/dataset01/data.csv`,
    /// batch transform stores the transformed data at
    /// `s3://bucket-name/output-name-prefix/input-name-prefix/data.csv.out`. Batch
    /// transform doesn't upload partially processed objects. For an input S3 object
    /// that contains multiple records, it creates an .`out` file only if the
    /// transform job succeeds on the entire file. When the input contains multiple
    /// S3 objects, the batch transform job processes the listed S3 objects and
    /// uploads only the output for successfully processed objects. If any object
    /// fails in the transform job batch transform marks the job as failed to prompt
    /// investigation.
    s3_output_path: []const u8,

    pub const json_field_names = .{
        .accept = "Accept",
        .assemble_with = "AssembleWith",
        .kms_key_id = "KmsKeyId",
        .s3_output_path = "S3OutputPath",
    };
};
