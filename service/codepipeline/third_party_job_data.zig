const ActionConfiguration = @import("action_configuration.zig").ActionConfiguration;
const ActionTypeId = @import("action_type_id.zig").ActionTypeId;
const AWSSessionCredentials = @import("aws_session_credentials.zig").AWSSessionCredentials;
const EncryptionKey = @import("encryption_key.zig").EncryptionKey;
const Artifact = @import("artifact.zig").Artifact;
const PipelineContext = @import("pipeline_context.zig").PipelineContext;

/// Represents information about the job data for a partner action.
pub const ThirdPartyJobData = struct {
    /// Represents information about an action configuration.
    action_configuration: ?ActionConfiguration = null,

    /// Represents information about an action type.
    action_type_id: ?ActionTypeId = null,

    /// Represents an Amazon Web Services session credentials object. These
    /// credentials are
    /// temporary credentials that are issued by Amazon Web Services Secure Token
    /// Service (STS).
    /// They can be used to access input and output artifacts in the S3 bucket used
    /// to store
    /// artifact for the pipeline in CodePipeline.
    artifact_credentials: ?AWSSessionCredentials = null,

    /// A system-generated token, such as a CodeDeploy deployment ID, that a job
    /// requires
    /// to continue the job asynchronously.
    continuation_token: ?[]const u8 = null,

    /// The encryption key used to encrypt and decrypt data in the artifact store
    /// for the
    /// pipeline, such as an Amazon Web Services Key Management Service (Amazon Web
    /// Services KMS)
    /// key. This is optional and might not be present.
    encryption_key: ?EncryptionKey = null,

    /// The name of the artifact that is worked on by the action, if any. This name
    /// might
    /// be system-generated, such as "MyApp", or it might be defined by the user
    /// when the action
    /// is created. The input artifact name must match the name of an output
    /// artifact generated
    /// by an action in an earlier action or stage of the pipeline.
    input_artifacts: ?[]const Artifact = null,

    /// The name of the artifact that is the result of the action, if any. This name
    /// might
    /// be system-generated, such as "MyBuiltApp", or it might be defined by the
    /// user when the
    /// action is created.
    output_artifacts: ?[]const Artifact = null,

    /// Represents information about a pipeline to a job worker.
    ///
    /// Does not include `pipelineArn` and `pipelineExecutionId`
    /// for ThirdParty jobs.
    pipeline_context: ?PipelineContext = null,

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
