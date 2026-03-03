/// Specifies the Amazon S3 location of a workflow definition file. This
/// structure contains the bucket name, object key, and optional version ID for
/// the workflow definition. Amazon Managed Workflows for Apache Airflow
/// Serverless takes a snapshot of the definition file at the time of workflow
/// creation or update, ensuring that the workflow behavior remains consistent
/// even if the source file is modified. The definition must be a valid YAML
/// file that uses supported Amazon Web Services operators and Amazon Managed
/// Workflows for Apache Airflow Serverless syntax.
pub const DefinitionS3Location = struct {
    /// The name of the Amazon S3 bucket that contains the workflow definition file.
    bucket: []const u8,

    /// The key (name) of the workflow definition file within the S3 bucket.
    object_key: []const u8,

    /// Optional. The version ID of the workflow definition file in Amazon S3. If
    /// not specified, the latest version is used.
    version_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket = "Bucket",
        .object_key = "ObjectKey",
        .version_id = "VersionId",
    };
};
