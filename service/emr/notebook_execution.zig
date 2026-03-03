const aws = @import("aws");

const ExecutionEngineConfig = @import("execution_engine_config.zig").ExecutionEngineConfig;
const NotebookS3LocationForOutput = @import("notebook_s3_location_for_output.zig").NotebookS3LocationForOutput;
const OutputNotebookFormat = @import("output_notebook_format.zig").OutputNotebookFormat;
const OutputNotebookS3LocationForOutput = @import("output_notebook_s3_location_for_output.zig").OutputNotebookS3LocationForOutput;
const NotebookExecutionStatus = @import("notebook_execution_status.zig").NotebookExecutionStatus;
const Tag = @import("tag.zig").Tag;

/// A notebook execution. An execution is a specific instance that an Amazon EMR
/// Notebook is run using the `StartNotebookExecution` action.
pub const NotebookExecution = struct {
    /// The Amazon Resource Name (ARN) of the notebook execution.
    arn: ?[]const u8 = null,

    /// The unique identifier of the Amazon EMR Notebook that is used for the
    /// notebook
    /// execution.
    editor_id: ?[]const u8 = null,

    /// The timestamp when notebook execution ended.
    end_time: ?i64 = null,

    /// The environment variables associated with the notebook execution.
    environment_variables: ?[]const aws.map.StringMapEntry = null,

    /// The execution engine, such as an Amazon EMR cluster, used to run the Amazon
    /// EMR notebook and perform the notebook execution.
    execution_engine: ?ExecutionEngineConfig = null,

    /// The reason for the latest status change of the notebook execution.
    last_state_change_reason: ?[]const u8 = null,

    /// The unique identifier of a notebook execution.
    notebook_execution_id: ?[]const u8 = null,

    /// A name for the notebook execution.
    notebook_execution_name: ?[]const u8 = null,

    /// The unique identifier of the Amazon EC2 security group associated with the
    /// Amazon EMR Notebook instance. For more information see [Specifying
    /// Amazon EC2 Security Groups for Amazon EMR
    /// Notebooks](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-managed-notebooks-security-groups.html) in the
    /// *Amazon EMR Management Guide*.
    notebook_instance_security_group_id: ?[]const u8 = null,

    /// Input parameters in JSON format passed to the Amazon EMR Notebook at runtime
    /// for
    /// execution.
    notebook_params: ?[]const u8 = null,

    /// The Amazon S3 location that stores the notebook execution input.
    notebook_s3_location: ?NotebookS3LocationForOutput = null,

    /// The output format for the notebook execution.
    output_notebook_format: ?OutputNotebookFormat = null,

    /// The Amazon S3 location for the notebook execution output.
    output_notebook_s3_location: ?OutputNotebookS3LocationForOutput = null,

    /// The location of the notebook execution's output file in Amazon S3.
    output_notebook_uri: ?[]const u8 = null,

    /// The timestamp when notebook execution started.
    start_time: ?i64 = null,

    /// The status of the notebook execution.
    ///
    /// * `START_PENDING` indicates that the cluster has received the execution
    /// request but execution has not begun.
    ///
    /// * `STARTING` indicates that the execution is starting on the
    /// cluster.
    ///
    /// * `RUNNING` indicates that the execution is being processed by the
    /// cluster.
    ///
    /// * `FINISHING` indicates that execution processing is in the final
    /// stages.
    ///
    /// * `FINISHED` indicates that the execution has completed without
    /// error.
    ///
    /// * `FAILING` indicates that the execution is failing and will not finish
    /// successfully.
    ///
    /// * `FAILED` indicates that the execution failed.
    ///
    /// * `STOP_PENDING` indicates that the cluster has received a
    /// `StopNotebookExecution` request and the stop is pending.
    ///
    /// * `STOPPING` indicates that the cluster is in the process of stopping the
    /// execution as a result of a `StopNotebookExecution` request.
    ///
    /// * `STOPPED` indicates that the execution stopped because of a
    /// `StopNotebookExecution` request.
    status: ?NotebookExecutionStatus = null,

    /// A list of tags associated with a notebook execution. Tags are user-defined
    /// key-value
    /// pairs that consist of a required key string with a maximum of 128 characters
    /// and an
    /// optional value string with a maximum of 256 characters.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .editor_id = "EditorId",
        .end_time = "EndTime",
        .environment_variables = "EnvironmentVariables",
        .execution_engine = "ExecutionEngine",
        .last_state_change_reason = "LastStateChangeReason",
        .notebook_execution_id = "NotebookExecutionId",
        .notebook_execution_name = "NotebookExecutionName",
        .notebook_instance_security_group_id = "NotebookInstanceSecurityGroupId",
        .notebook_params = "NotebookParams",
        .notebook_s3_location = "NotebookS3Location",
        .output_notebook_format = "OutputNotebookFormat",
        .output_notebook_s3_location = "OutputNotebookS3Location",
        .output_notebook_uri = "OutputNotebookURI",
        .start_time = "StartTime",
        .status = "Status",
        .tags = "Tags",
    };
};
