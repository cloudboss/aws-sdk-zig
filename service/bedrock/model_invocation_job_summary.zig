const ModelInvocationJobInputDataConfig = @import("model_invocation_job_input_data_config.zig").ModelInvocationJobInputDataConfig;
const ModelInvocationType = @import("model_invocation_type.zig").ModelInvocationType;
const ModelInvocationJobOutputDataConfig = @import("model_invocation_job_output_data_config.zig").ModelInvocationJobOutputDataConfig;
const ModelInvocationJobStatus = @import("model_invocation_job_status.zig").ModelInvocationJobStatus;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

/// A summary of a batch inference job.
pub const ModelInvocationJobSummary = struct {
    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If this token matches a previous request, Amazon
    /// Bedrock ignores the request, but does not return an error. For more
    /// information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_request_token: ?[]const u8 = null,

    /// The time at which the batch inference job ended.
    end_time: ?i64 = null,

    /// The number of records that failed to process in the batch inference job.
    error_record_count: ?i64 = null,

    /// Details about the location of the input to the batch inference job.
    input_data_config: ModelInvocationJobInputDataConfig,

    /// The Amazon Resource Name (ARN) of the batch inference job.
    job_arn: []const u8,

    /// The time at which the batch inference job times or timed out.
    job_expiration_time: ?i64 = null,

    /// The name of the batch inference job.
    job_name: []const u8,

    /// The time at which the batch inference job was last modified.
    last_modified_time: ?i64 = null,

    /// If the batch inference job failed, this field contains a message describing
    /// why the job failed.
    message: ?[]const u8 = null,

    /// The unique identifier of the foundation model used for model inference.
    model_id: []const u8,

    /// The invocation endpoint for ModelInvocationJob
    model_invocation_type: ?ModelInvocationType = null,

    /// Details about the location of the output of the batch inference job.
    output_data_config: ModelInvocationJobOutputDataConfig,

    /// The number of records that have been processed in the batch inference job.
    processed_record_count: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the service role with permissions to carry
    /// out and manage batch inference. You can use the console to create a default
    /// service role or follow the steps at [Create a service role for batch
    /// inference](https://docs.aws.amazon.com/bedrock/latest/userguide/batch-iam-sr.html).
    role_arn: []const u8,

    /// The status of the batch inference job.
    ///
    /// The following statuses are possible:
    ///
    /// * Submitted – This job has been submitted to a queue for validation.
    /// * Validating – This job is being validated for the requirements described in
    ///   [Format and upload your batch inference
    ///   data](https://docs.aws.amazon.com/bedrock/latest/userguide/batch-inference-data.html). The criteria include the following:
    ///
    /// * Your IAM service role has access to the Amazon S3 buckets containing your
    ///   files.
    /// * Your files are .jsonl files and each individual record is a JSON object in
    ///   the correct format. Note that validation doesn't check if the `modelInput`
    ///   value matches the request body for the model.
    /// * Your files fulfill the requirements for file size and number of records.
    ///   For more information, see [Quotas for Amazon
    ///   Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/quotas.html).
    ///
    /// * Scheduled – This job has been validated and is now in a queue. The job
    ///   will automatically start when it reaches its turn.
    /// * Expired – This job timed out because it was scheduled but didn't begin
    ///   before the set timeout duration. Submit a new job request.
    /// * InProgress – This job has begun. You can start viewing the results in the
    ///   output S3 location.
    /// * Completed – This job has successfully completed. View the output files in
    ///   the output S3 location.
    /// * PartiallyCompleted – This job has partially completed. Not all of your
    ///   records could be processed in time. View the output files in the output S3
    ///   location.
    /// * Failed – This job has failed. Check the failure message for any further
    ///   details. For further assistance, reach out to the [Amazon Web Services
    ///   Support Center](https://console.aws.amazon.com/support/home/).
    /// * Stopped – This job was stopped by a user.
    /// * Stopping – This job is being stopped by a user.
    status: ?ModelInvocationJobStatus = null,

    /// The time at which the batch inference job was submitted.
    submit_time: i64,

    /// The number of records that were successfully processed in the batch
    /// inference job.
    success_record_count: ?i64 = null,

    /// The number of hours after which the batch inference job was set to time out.
    timeout_duration_in_hours: ?i32 = null,

    /// The total number of records in the batch inference job.
    total_record_count: ?i64 = null,

    /// The configuration of the Virtual Private Cloud (VPC) for the data in the
    /// batch inference job. For more information, see [Protect batch inference jobs
    /// using a
    /// VPC](https://docs.aws.amazon.com/bedrock/latest/userguide/batch-vpc).
    vpc_config: ?VpcConfig = null,

    pub const json_field_names = .{
        .client_request_token = "clientRequestToken",
        .end_time = "endTime",
        .error_record_count = "errorRecordCount",
        .input_data_config = "inputDataConfig",
        .job_arn = "jobArn",
        .job_expiration_time = "jobExpirationTime",
        .job_name = "jobName",
        .last_modified_time = "lastModifiedTime",
        .message = "message",
        .model_id = "modelId",
        .model_invocation_type = "modelInvocationType",
        .output_data_config = "outputDataConfig",
        .processed_record_count = "processedRecordCount",
        .role_arn = "roleArn",
        .status = "status",
        .submit_time = "submitTime",
        .success_record_count = "successRecordCount",
        .timeout_duration_in_hours = "timeoutDurationInHours",
        .total_record_count = "totalRecordCount",
        .vpc_config = "vpcConfig",
    };
};
