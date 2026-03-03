/// The configuration containing output file information for a batch job.
pub const OutputDataConfig = struct {
    /// The identifier of the KMS key you want Voice ID to use to encrypt the
    /// output file of a speaker enrollment job/fraudster registration job.
    kms_key_id: ?[]const u8 = null,

    /// The S3 path of the folder where Voice ID writes the job output file. It has
    /// a
    /// `*.out` extension. For example, if the input file name is
    /// `input-file.json` and the output folder path is
    /// `s3://output-bucket/output-folder`, the full output file path is
    /// `s3://output-bucket/output-folder/job-Id/input-file.json.out`.
    s3_uri: []const u8,

    pub const json_field_names = .{
        .kms_key_id = "KmsKeyId",
        .s3_uri = "S3Uri",
    };
};
