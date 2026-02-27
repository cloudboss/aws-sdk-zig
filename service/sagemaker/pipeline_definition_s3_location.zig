/// The location of the pipeline definition stored in Amazon S3.
pub const PipelineDefinitionS3Location = struct {
    /// Name of the S3 bucket.
    bucket: []const u8,

    /// The object key (or key name) uniquely identifies the object in an S3 bucket.
    object_key: []const u8,

    /// Version Id of the pipeline definition file. If not specified, Amazon
    /// SageMaker will retrieve the latest version.
    version_id: ?[]const u8,

    pub const json_field_names = .{
        .bucket = "Bucket",
        .object_key = "ObjectKey",
        .version_id = "VersionId",
    };
};
