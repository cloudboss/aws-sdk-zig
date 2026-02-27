const ActionConfiguration = @import("action_configuration.zig").ActionConfiguration;
const ActionTypeId = @import("action_type_id.zig").ActionTypeId;
const AWSSessionCredentials = @import("aws_session_credentials.zig").AWSSessionCredentials;
const EncryptionKey = @import("encryption_key.zig").EncryptionKey;
const Artifact = @import("artifact.zig").Artifact;
const PipelineContext = @import("pipeline_context.zig").PipelineContext;

/// Represents other information about a job required for a job worker to
/// complete the
/// job.
pub const JobData = struct {
    /// Represents information about an action configuration.
    action_configuration: ?ActionConfiguration,

    /// Represents information about an action type.
    action_type_id: ?ActionTypeId,

    /// Represents an Amazon Web Services session credentials object. These
    /// credentials are
    /// temporary credentials that are issued by Amazon Web Services Secure Token
    /// Service (STS).
    /// They can be used to access input and output artifacts in the S3 bucket used
    /// to store
    /// artifacts for the pipeline in CodePipeline.
    artifact_credentials: ?AWSSessionCredentials,

    /// A system-generated token, such as a deployment ID, required by a job to
    /// continue
    /// the job asynchronously.
    continuation_token: ?[]const u8,

    /// Represents information about the key used to encrypt data in the artifact
    /// store,
    /// such as an KMS key.
    encryption_key: ?EncryptionKey,

    /// The artifact supplied to the job.
    input_artifacts: ?[]const Artifact,

    /// The output of the job.
    output_artifacts: ?[]const Artifact,

    /// Represents information about a pipeline to a job worker.
    ///
    /// Includes `pipelineArn` and `pipelineExecutionId` for
    /// custom jobs.
    pipeline_context: ?PipelineContext,

    pub const json_field_names = .{
        .action_configuration = "actionConfiguration",
        .action_type_id = "actionTypeId",
        .artifact_credentials = "artifactCredentials",
        .continuation_token = "continuationToken",
        .encryption_key = "encryptionKey",
        .input_artifacts = "inputArtifacts",
        .output_artifacts = "outputArtifacts",
        .pipeline_context = "pipelineContext",
    };
};
