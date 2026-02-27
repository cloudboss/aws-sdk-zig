const aws = @import("aws");

const ExternalSourceConfiguration = @import("external_source_configuration.zig").ExternalSourceConfiguration;
const ImportJobType = @import("import_job_type.zig").ImportJobType;
const ImportJobStatus = @import("import_job_status.zig").ImportJobStatus;

/// Summary information about the import job.
pub const ImportJobSummary = struct {
    /// The timestamp when the import job was created.
    created_time: i64,

    /// The configuration information of the external source that the resource data
    /// are imported from.
    external_source_configuration: ?ExternalSourceConfiguration,

    /// The identifier of the import job.
    import_job_id: []const u8,

    /// The type of import job.
    import_job_type: ImportJobType,

    /// The Amazon Resource Name (ARN) of the knowledge base.
    knowledge_base_arn: []const u8,

    /// The identifier of the knowledge base.
    knowledge_base_id: []const u8,

    /// The timestamp when the import job was last modified.
    last_modified_time: i64,

    /// The metadata fields of the imported Amazon Q in Connect resources.
    metadata: ?[]const aws.map.StringMapEntry,

    /// The status of the import job.
    status: ImportJobStatus,

    /// A pointer to the uploaded asset. This value is returned by
    /// [StartContentUpload](https://docs.aws.amazon.com/wisdom/latest/APIReference/API_StartContentUpload.html).
    upload_id: []const u8,

    pub const json_field_names = .{
        .created_time = "createdTime",
        .external_source_configuration = "externalSourceConfiguration",
        .import_job_id = "importJobId",
        .import_job_type = "importJobType",
        .knowledge_base_arn = "knowledgeBaseArn",
        .knowledge_base_id = "knowledgeBaseId",
        .last_modified_time = "lastModifiedTime",
        .metadata = "metadata",
        .status = "status",
        .upload_id = "uploadId",
    };
};
