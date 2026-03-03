const aws = @import("aws");

const ExternalSourceConfiguration = @import("external_source_configuration.zig").ExternalSourceConfiguration;
const ImportJobType = @import("import_job_type.zig").ImportJobType;
const ImportJobStatus = @import("import_job_status.zig").ImportJobStatus;

/// Summary information about the import job.
pub const ImportJobData = struct {
    /// The timestamp when the import job was created.
    created_time: i64,

    external_source_configuration: ?ExternalSourceConfiguration = null,

    /// The link to donwload the information of resource data that failed to be
    /// imported.
    failed_record_report: ?[]const u8 = null,

    /// The identifier of the import job.
    import_job_id: []const u8,

    /// The type of the import job.
    import_job_type: ImportJobType,

    /// The Amazon Resource Name (ARN) of the knowledge base.
    knowledge_base_arn: []const u8,

    /// The identifier of the knowledge base. This should not be a QUICK_RESPONSES
    /// type knowledge
    /// base if you're storing Wisdom Content resource to it.
    knowledge_base_id: []const u8,

    /// The timestamp when the import job data was last modified.
    last_modified_time: i64,

    /// The metadata fields of the imported Wisdom resources.
    metadata: ?[]const aws.map.StringMapEntry = null,

    /// The status of the import job.
    status: ImportJobStatus,

    /// A pointer to the uploaded asset. This value is returned by
    /// [StartContentUpload](https://docs.aws.amazon.com/wisdom/latest/APIReference/API_StartContentUpload.html).
    upload_id: []const u8,

    /// The download link to the resource file that is uploaded to the import job.
    url: []const u8,

    /// The expiration time of the URL as an epoch timestamp.
    url_expiry: i64,

    pub const json_field_names = .{
        .created_time = "createdTime",
        .external_source_configuration = "externalSourceConfiguration",
        .failed_record_report = "failedRecordReport",
        .import_job_id = "importJobId",
        .import_job_type = "importJobType",
        .knowledge_base_arn = "knowledgeBaseArn",
        .knowledge_base_id = "knowledgeBaseId",
        .last_modified_time = "lastModifiedTime",
        .metadata = "metadata",
        .status = "status",
        .upload_id = "uploadId",
        .url = "url",
        .url_expiry = "urlExpiry",
    };
};
